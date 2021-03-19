import neo4j from 'neo4j-driver';

function connectNeo4j(): any {
  const driver = neo4j.driver('bolt://3.83.214.196:7687', neo4j.auth.basic('neo4j', 'gate-honk-evaluations'), {});

  const session = driver.session({ database: 'neo4j' });

  return { driver, session };
}

function disconnectNeo4j(session, driver) {
  session.close();
  driver.close();
}

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

async function getCQRS(session, system): Promise<any> {
  const query = `
  MATCH
  (qSide:Service)-[:BELONGS_TO]->(:System {title:$system}),
  (qSide)-[:EXPOSES]->(:Operation {verb:'GET'}),
  (qSide)-[:SUBSCRIBES_TO]->(channel:Channel)<-[:PUBLISHES_TO]-(cSide:Service)
  WITH COLLECT(distinct cSide) AS commandServices, qSide AS queryService
  RETURN queryService, commandServices
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

function interpretCQRS(result): any {
  const { records } = result;

  if (!records.length) return null;

  const CQRSs = [];
  records.forEach((record) => {
    const queryService = record.get('queryService');
    const commandServices = record.get('commandServices');
    CQRSs.push({
      queryService: { ...queryService.properties },
      commandServices: commandServices.map(({ properties }) => properties),
    });
  });

  return CQRSs;
}

async function main() {
  const { session, driver } = connectNeo4j();

  let result = await getSharedDBs(session, 'Fake');
  const sharedDBs = interpretSharedDBs(result);
  console.log('shared DBs:', sharedDBs);

  result = await getCQRS(session, 'Pingr');
  const cqrs = interpretCQRS(result);
  console.log('CQRS:', cqrs);

  disconnectNeo4j(session, driver);
}

main();
