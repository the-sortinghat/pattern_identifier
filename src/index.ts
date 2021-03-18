import neo4j from 'neo4j-driver';
const driver = neo4j.driver('bolt://3.83.214.196:7687', neo4j.auth.basic('neo4j', 'gate-honk-evaluations'), {});

const session = driver.session({ database: 'neo4j' });

function findSharedDBs(session, system) {
  const query = `
  MATCH (sharedDBCandidate:Database)<-[usage:USES]-(s:Service)-[:SVC_BLONGS_TO_SYS]->(sys:System {title:$system})
  WITH sharedDBCandidate.name AS db, COUNT(s) AS nServices
  WHERE nServices >= $nServices
  RETURN db, nServices;
  `;

  const params = { system, nServices: 2 };

  return new Promise((res, rej) => {
    session
      .run(query, params)
      .then((result) => {
        if (result.records.length)
          result.records.forEach((record) => {
            const db = record.get('db');
            const n = record.get('nServices');

            console.log(`${db}:\t${n}`);
          });
        else console.log('no records found');
        res(result.records);
      })
      .catch((error) => {
        rej(error);
      });
  });
}

function findCQRSQueryCandidates(session) {
  const query = `
  MATCH (Auth:Service {name:'Autenticação'})-[:REQUESTS_FROM {verb:'GET'}]->(qCandidate:Service)<-[:SENDS_TO]-(n:Service)
  RETURN qCandidate, n;
  `;

  return new Promise((res, rej) => {
    session
      .run(query)
      .then((result) => {
        console.log(result.records);
        res(result.records);
      })
      .catch((err) => rej(err));
  });
}

findSharedDBs(session, 'Pingr').then(() => {
  findCQRSQueryCandidates(session);
});
