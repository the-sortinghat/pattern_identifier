import { Service } from './service';
import { System } from './system';
import { Database } from './database';

describe('service', () => {
  let sys: System;

  beforeEach(() => {
    sys = new System('foo', 'bar');
  });

  it('is defined', () => {
    expect(Service).toBeDefined();
  });

  it('contains a name', () => {
    expect(new Service('foo', sys).name).toBe('foo');
  });

  it('accepts a system as constructor argument', () => {
    const svc = new Service('foo', sys);
    expect(svc.system).toBeDefined();
    expect(svc.system).toEqual(sys);
  });

  it('also registers itself in its parent system', () => {
    sys.addChildService = jest.fn();

    const svc = new Service('foo', sys);

    expect(sys.addChildService).toHaveBeenCalledWith(svc);
  });

  it('accepts adding database usage', () => {
    const svc = new Service('foo', sys);

    const mockDB = new Database('mock', 'mock', 'mockdb');
    mockDB.acceptConnectionFromService = jest.fn();
    svc.connectToDatabase(mockDB);

    expect(svc.databases).toHaveLength(1);
    expect(mockDB.acceptConnectionFromService).toHaveBeenCalledWith(svc);
  });
});
