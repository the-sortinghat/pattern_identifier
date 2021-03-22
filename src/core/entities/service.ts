import { System } from './system';

export class Service {
  constructor(readonly name: string, readonly system: System) {
    system.addChildService(this);
  }
}
