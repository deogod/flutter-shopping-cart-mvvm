import 'package:dartz/dartz.dart';

import '../../../../achitecture.dart';

class GetPedidosUsecase {
  final PedidoRepository repository;

  GetPedidosUsecase(this.repository);

  Future<Either<Failure, List<Pedido>>> call() {
    return repository.getPedidos();
  }
}
