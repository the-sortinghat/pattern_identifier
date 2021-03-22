import {Database} from './database';

describe(Database, () => {
  let db: Database;

  beforeEach(() => {
    db = new Database('foo', 'document', 'mongodb');
  });

  'name model make'.split(' ').forEach((attr: string): void => {
    it(`defines a ${attr}`, () => {
      expect(db.name).toBeDefined();
    });
  });
});
