import 'package:dartz/dartz.dart';

import '../../../../achitecture.dart';

abstract class PedidoRepository {
  Future<Either<Failure, List<Pedido>>> getPedidos();
  Future<Either<Failure, void>> addPedido(Pedido pedido);
}
