// shared DBs
MATCH (db:Database)<-[r:USES]-(svc:Service)-[:BELONGS_TO]->(:System {name:'Pingr'})
WITH COUNT(svc) AS nSvcs, COLLECT(svc) AS svcs, db AS sharedDB
WHERE nSvcs > 1
RETURN sharedDB, nSvcs, svcs

// CQRS
MATCH
(qSide:Service)-[:EXPOSES]->(:Operation {verb:'GET'}),
(qSide)-[:SUBSCRIBES_TO]->(channel:Channel)<-[:PUBLISHES_TO]-(cSide:Service)
WITH COLLECT(distinct cSide) AS commandServices, qSide AS queryService
RETURN queryService, commandServices
