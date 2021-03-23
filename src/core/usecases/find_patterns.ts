import { CQRS } from '../entities/cqrs';
import { SystemDataServiceInterface } from '../adapters/system_data_service.interface';

export interface PatternsHashInterface {
  cqrs: CQRS[];
}

export class FindPatterns {
  constructor(private readonly systemDS: SystemDataServiceInterface) {}

  async run(systemTitle: string): Promise<PatternsHashInterface> {
    const cqrsCandidates = await this.systemDS.fetchCQRSCandidates(systemTitle);

    return { cqrs: cqrsCandidates };
  }
}
