import { neo4jAdapter } from './neo4j';
import { sharedDB } from './shared_db';
import { CQRS } from './cqrs';

async function analyze(system): Promise<void> {
  const { session, driver } = neo4jAdapter.connect();

  console.log('=======================\n');
  console.log(`Data relative to system "${system}"`);

  await sharedDB.run(session, system);
  await CQRS.run(session, system);

  console.log('\n\n\n=======================');

  neo4jAdapter.disconnect(session, driver);
}

async function main(): Promise<void> {
  await analyze('Hacknizer');
  await analyze('Pingr');
  await analyze('Fake');
}

main();
