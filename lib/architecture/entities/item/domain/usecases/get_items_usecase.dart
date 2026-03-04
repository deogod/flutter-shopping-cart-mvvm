import 'package:dartz/dartz.dart';

import '../../../../achitecture.dart';

class GetItemsUsecase {
  final ItemRepository repository;

  GetItemsUsecase(this.repository);

  Future<Either<Failure, List<Item>>> call() {
    return repository.getItems();
  }
}
