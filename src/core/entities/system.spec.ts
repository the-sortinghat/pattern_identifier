import {System} from './system';

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
});
