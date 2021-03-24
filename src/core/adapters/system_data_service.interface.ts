import { System } from '../entities/system';
import { CQRS } from '../entities/cqrs';

export interface SystemDataServiceInterface {
  findOne: (title: string) => Promise<System | null>;
  fetchCQRSCandidates: (system: System) => Promise<CQRS[]>;
}
