import { neo4jAdapter } from './neo4j';
import { sharedDB } from './shared_db';
import { CQRS } from './cqrs';

async function main(): Promise<void> {
  const { session, driver } = neo4jAdapter.connect();

  await sharedDB.run(session);
  await CQRS.run(session);

  neo4jAdapter.disconnect(session, driver);
}

main();
