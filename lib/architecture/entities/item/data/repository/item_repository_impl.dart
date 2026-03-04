import 'package:dartz/dartz.dart';

import '../../../../achitecture.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemDataSource remote;

  ItemRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<Item>>> getItems() async {
    try {
      final items = await remote.getItems();
      return Right(items);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
