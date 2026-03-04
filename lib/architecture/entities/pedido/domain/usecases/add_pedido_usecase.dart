import 'package:dartz/dartz.dart';

import '../../../../achitecture.dart';

class AddPedidoUsecase {
  final PedidoRepository repository;

  AddPedidoUsecase(this.repository);

  Future<Either<Failure, void>> call(Pedido pedido) {
    return repository.addPedido(pedido);
  }
}
