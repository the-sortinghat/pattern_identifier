import neo4jAdapter from './neo4j';
import sharedDB from './shared_db';
import CQRS from './cqrs';
import APIGateway from './api_gateway';

async function analyze(system): Promise<void> {
  const { session, driver } = neo4jAdapter.connect();

  console.log('=======================\n');
  console.log(`Data relative to system "${system}"`);

  await sharedDB.run(session, system);
  await CQRS.run(session, system);
  await APIGateway.run(session, system);

  console.log('\n\n\n=======================');

  neo4jAdapter.disconnect(session, driver);
}

async function main(): Promise<void> {
  await analyze('Hacknizer');
  await analyze('Pingr');
  await analyze('Fake');
}

main();
