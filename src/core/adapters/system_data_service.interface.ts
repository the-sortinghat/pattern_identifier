import { CQRS } from '../entities/cqrs';

export interface SystemDataServiceInterface {
  fetchCQRSCandidates: (systemTitle: string) => Promise<CQRS[]>;
}
