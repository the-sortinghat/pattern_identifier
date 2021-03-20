async function getAPIGateway(session, system): Promise<any> {
  const query = `
  MATCH
    (o:Operation),
    (sys:System {title:$system})<-[:BELONGS_TO]-(gate:Service)-[proxy:PROXIES_TO]->(:Operation)
  WITH
    gate AS apiGateway,
    (1.0 * COUNT(proxy) / COUNT(o)) AS rate
  WHERE rate >= $coeficient
  RETURN apiGateway, rate
  `;

  const params = { system, coeficient: 0.7 };

  let result = null;
  try {
    result = await session.run(query, params);
  } catch (err) {
    console.log(err);
  } finally {
    return result;
  }
}

function interpretAPIGateway(result): any {
  const { records } = result;

  if (!records.length) return null;

  const apiGateways = [];
  records.forEach((record) => {
    const { properties } = record.get('apiGateway');
    const rate = record.get('rate');

    apiGateways.push({ service: properties, rate });
  });

  return apiGateways;
}

async function main(session, system): Promise<void> {
  const result = await getAPIGateway(session, system);
  const apiGateway = interpretAPIGateway(result);
  console.log('API Gateway:', apiGateway);
}

export default {
  run: main,
};
