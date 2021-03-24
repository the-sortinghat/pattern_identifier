import neo4jAdapter from './neo4j';
import { FindPatterns } from './core/usecases/find_patterns';
import { Neo4JSystemDataService } from './app/data_services/neo4j.system_data_service';

async function analyze(system): Promise<void> {
  const { session, driver } = neo4jAdapter.connect();

  console.log('=======================\n');
  console.log(`Data relative to system "${system}"`);

  const sysDB = new Neo4JSystemDataService(session);
  const findPatterns = new FindPatterns(sysDB);

  const { cqrs } = await findPatterns.run(system);

  console.log(cqrs);

  console.log('\n\n\n=======================');

  neo4jAdapter.disconnect(session, driver);
}

async function main(): Promise<void> {
  await analyze('Hacknizer');
  await analyze('Pingr');
  await analyze('Fake');
}

main();
