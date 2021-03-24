import { Session, QueryResult, Record } from 'neo4j-driver';
import { SystemDataServiceInterface } from '../../core/adapters/system_data_service.interface';
import { System } from '../../core/entities/system';
import { Service } from '../../core/entities/service';
import { CQRS } from '../../core/entities/cqrs';

interface Params {
  [key: string]: string;
}

interface PreparedQuery {
  query: string;
  params: Params;
}

export class Neo4JSystemDataService implements SystemDataServiceInterface {
  private system: System;

  constructor(private session: Session) {}

  async findOne(title: string): Promise<System | null> {
    const { query, params } = this.prepareFindQuery(title);
    const { records } = await this.session.run(query, params);
    if (records.length) {
      const { properties } = records[0].get('sys');
      return new System(title, properties.description);
    } else return null;
  }

  async fetchCQRSCandidates(system: System): Promise<CQRS[]> {
    this.system = system;
    const { query, params } = this.prepareCQRSQuery(this.system.title);
    const result = await this.runQuery(query, params);
    if (result) return this.parseData(result);
    else return [];
  }

  private recordVarToService({ properties }: any): Service {
    return new Service(properties.name, this.system);
  }

  private recordToCQRS(record: Record): CQRS {
    const queryService = this.recordVarToService(record.get('queryService'));

    const commandServices = record
      .get('commandServices')
      .map((recordVar: any): Service => this.recordVarToService(recordVar));

    return new CQRS(queryService, commandServices);
  }

  private parseData(result: QueryResult): CQRS[] {
    const { records } = result;

    return records.map((record: Record): CQRS => this.recordToCQRS(record));
  }

  private async runQuery(query: string, params: Params): Promise<QueryResult | null> {
    try {
      const res = await this.session.run(query, params);
      return res;
    } catch (e) {
      console.log(e);
      return null;
    }
  }

  private prepareFindQuery(systemTitle: string): PreparedQuery {
    const query = `
      MATCH (sys:System {title:$system})
      RETURN sys;
    `;
    const params = { system: systemTitle };

    return { query, params };
  }

  private prepareCQRSQuery(systemTitle: string): PreparedQuery {
    const query = `
      MATCH
      (qSide:Service)-[:BELONGS_TO]->(:System {title:$system}),
      (qSide)-[:EXPOSES]->(:Operation {verb:'GET'}),
      (qSide)-[:SUBSCRIBES_TO]->(channel:Channel)<-[:PUBLISHES_TO]-(cSide:Service)
      WITH COLLECT(distinct cSide) AS commandServices, qSide AS queryService
      RETURN queryService, commandServices
    `;

    const params = { system: systemTitle };

    return { query, params };
  }
}
