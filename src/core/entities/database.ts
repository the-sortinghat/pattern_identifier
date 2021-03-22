import { Service } from './service';

export class Database {
  private _connectedServices: Service[] = [];

  constructor(readonly name: string, readonly model: string, readonly make: string) {}

  acceptConnectionFromService(svc: Service): void {
    this._connectedServices.push(svc);
  }

  get services(): Service[] {
    return this._connectedServices;
  }
}
