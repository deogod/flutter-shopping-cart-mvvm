import 'dart:math';

import '../../../../achitecture.dart';

class CheckoutRemoteDataSource implements CheckoutDataSource {
  bool shouldFail() {
    return Random().nextDouble() < 0.4;
  }

  @override
  Future<void> doCheckout(CheckoutEntity checkout) async {
    await Future.delayed(const Duration(seconds: 2));

    if (shouldFail()) {
      throw Exception('Erro ao processar o checkout. Tente novamente.');
    }
  }
}
