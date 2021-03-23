import { CQRS } from './cqrs';
import { Service } from './service';
import { System } from './system';

describe(CQRS, () => {
  let cqrs: CQRS;
  let queryService: Service;
  let commandServices: Service[];

  beforeEach(() => {
    const sys = new System('foo', 'bar');
    queryService = new Service('query', sys);
    commandServices = [new Service('command', sys)];

    cqrs = new CQRS(queryService, commandServices);
  });

  it('has a single query service and a list of command services', () => {
    expect(cqrs.queryService).toBeDefined();
    expect(cqrs.queryService).toEqual(queryService);
    expect(cqrs.commandServices).toEqual(commandServices);
  });
});
