import 'package:dartz/dartz.dart';

import '../../../../achitecture.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, void>> doCheckout(CheckoutEntity checkout);
}
