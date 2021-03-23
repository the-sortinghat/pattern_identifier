import { Service } from './service';

export class CQRS {
  constructor(readonly queryService: Service, readonly commandServices: Service[]) {}
}
