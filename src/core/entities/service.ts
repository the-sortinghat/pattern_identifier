import { Database } from './database';
import { System } from './system';

export class Service {
  private _databases: Database[] = [];

  constructor(readonly name: string, readonly system: System) {
    system.addChildService(this);
  }

  connectToDatabase(db: Database): void {
    this._databases.push(db);
    db.acceptConnectionFromService(this);
  }

  get databases(): Database[] {
    return this._databases;
  }
}
