import 'package:dartz/dartz.dart';

import '../../../../achitecture.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSource dataSource;

  CheckoutRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, void>> doCheckout(CheckoutEntity checkout) async {
    try {
      await dataSource.doCheckout(checkout);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
