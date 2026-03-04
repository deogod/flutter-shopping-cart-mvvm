import 'package:dartz/dartz.dart';

import '../../../../achitecture.dart';

abstract class ItemRepository {
  Future<Either<Failure, List<Item>>> getItems();
}
