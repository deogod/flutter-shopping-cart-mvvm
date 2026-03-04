import 'package:dartz/dartz.dart';

import '../../../../achitecture.dart';

class DoCheckoutUseCase {
  final CheckoutRepository repository;

  DoCheckoutUseCase(this.repository);

  Future<Either<Failure, void>> call(CheckoutEntity checkout) {
    return repository.doCheckout(checkout);
  }
}
