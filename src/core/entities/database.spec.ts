import { Database } from './database';

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

  it('accepts connections from services', () => {
    const mockService = {
      name: 'mock',
      system: {
        title: 'foo',
        description: 'bar',
      },
      connectToDatabase: jest.fn(),
      databases: [],
    };

    db.acceptConnectionFromService(mockService);

    expect(db.services).toHaveLength(1);
    expect(db.services[0]).toEqual(mockService);
  });
});
