async function getSharedDBs(session, system): Promise<any> {
  const query = `
  MATCH (db:Database)<-[r:USES]-(svc:Service)-[:BELONGS_TO]->(:System {name:$system})
  WITH COUNT(svc) AS nSvcs, COLLECT(svc) AS svcs, db AS sharedDB
  WHERE nSvcs > 1
  RETURN sharedDB, nSvcs, svcs
  `;

  const params = { system };

  let result = null;
  try {
    result = await session.run(query, params);
  } catch (err) {
    console.log(err);
  } finally {
    return result;
  }
}

function interpretSharedDBs(result): any {
  const { records } = result;

  if (!records.length) return null;

  const sharedDBs = [];
  records.forEach((record) => {
    const sharedDB = record.get('sharedDB');
    const svcs = record.get('svcs');
    const nSvcs = record.get('nSvcs');

    sharedDBs.push({
      db: { ...sharedDB.properties },
      sharingDegree: nSvcs.low,
      sharingServices: [...svcs.map(({ properties }) => properties)],
    });
  });

  return sharedDBs;
}

async function main(session, system): Promise<void> {
  const result = await getSharedDBs(session, system);
  const sharedDBs = interpretSharedDBs(result);
  console.log('shared DBs:', sharedDBs);
}

export const sharedDB = {
  run: main,
};
