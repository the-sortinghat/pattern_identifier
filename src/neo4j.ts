import { config } from 'dotenv';
import neo4j from 'neo4j-driver';

config();

function connectNeo4j(): any {
  const url = process.env.NEO4J_URL;
  const user = process.env.NEO4j_USER;
  const pw = process.env.NEO4J_PASSWORD;

  const driver = neo4j.driver(url, neo4j.auth.basic(user, pw), {});

  const session = driver.session({ database: 'neo4j' });

  return { driver, session };
}

function disconnectNeo4j(session, driver): void {
  session.close();
  driver.close();
}

export const neo4jAdapter = {
  connect: connectNeo4j,
  disconnect: disconnectNeo4j,
};
