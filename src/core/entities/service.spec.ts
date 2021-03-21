import {Service} from './service';
import {System} from './system';

describe('service', () => {
  it('is defined', () => {
    expect(Service).toBeDefined();
  });

  it('contains a name', () => {
    expect(new Service('foo').name).toBe('foo');
  });
});
