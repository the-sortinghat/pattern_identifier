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

async function main(session): Promise<void> {
  const result = await getCQRS(session, 'Pingr');
  const cqrs = interpretCQRS(result);
  console.log('CQRS:', cqrs);
}

export const CQRS = {
  run: main,
};
