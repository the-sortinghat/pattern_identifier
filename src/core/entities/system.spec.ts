import { System } from './system';
import { Service } from './service';

describe(System, () => {
  let system: System;

  beforeEach(() => {
    system = new System('foo', 'bar');
  });

  it('defines title', () => {
    expect(system.title).toBeDefined();
    expect(system.title).toBe('foo');
  });

  it('defines description', () => {
    expect(system.description).toBeDefined();
    expect(system.description).toBe('bar');
  });

  it('accepts registration of child services', () => {
    const oldImpl = system.addChildService;
    system.addChildService = jest.fn();
    const service = new Service('foo', system);

    system.addChildService = oldImpl;
    system.addChildService(service);
    expect(system.services).toHaveLength(1);
    expect(system.services[0]).toEqual(service);
  });
});
