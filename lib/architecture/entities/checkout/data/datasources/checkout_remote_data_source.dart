import 'dart:math';

import '../../../../achitecture.dart';

class CheckoutRemoteDataSource implements CheckoutDataSource {
  bool shouldFail() {
    return Random().nextDouble() < 0.4;
  }

  @override
  Future<void> doCheckout(CheckoutEntity checkout) async {
    //DELAY SIMULADO PARA DEMONSTRAR O LOADING
    //40% DE CHANCE DE FALHA PARA DEMONSTRAR O ESTADO DE ERRO

    await Future.delayed(const Duration(seconds: 2));

    if (shouldFail()) {
      throw Exception('Erro ao processar o checkout. Tente novamente.');
    }
  }
}
