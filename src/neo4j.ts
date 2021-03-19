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

export const neo4jAdapter = {
  connect: connectNeo4j,
  disconnect: disconnectNeo4j,
};
