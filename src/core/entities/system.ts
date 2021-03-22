import {Service} from './service';

export class System {
  private _services: Service[] = [];

  constructor(readonly title: string, readonly description: string) {}

  addChildService(service: Service): void {
    this._services.push(service);
  }

  get services(): Service[] {
    return this._services;
  }
}
