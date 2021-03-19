import { neo4jAdapter } from './neo4j';
import { sharedDB } from './shared_db';
import { CQRS } from './cqrs';

async function main(): Promise<void> {
  const { session, driver } = neo4jAdapter.connect();

  const system = 'Hacknizer';

  console.log(`Data relative to system "${system}"`);

  await sharedDB.run(session, system);
  await CQRS.run(session, system);

  neo4jAdapter.disconnect(session, driver);
}

main();
