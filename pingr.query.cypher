MATCH (sharedDBCandidate:Database)<-[usage:USES]-(s:Service)-[:SVC_BLONGS_TO_SYS]->(sys:System {title:'Pingr'})
RETURN sharedDBCandidate, COUNT(s);

MATCH (Auth:Service {name:'Autenticação'})-[:REQUESTS_FROM {verb:'GET'}]->(qCandidate:Service)<-[:SENDS_TO]-(n:Service)
RETURN qCandidate, n;
