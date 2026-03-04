import '../../../../achitecture.dart';

abstract class PedidoDataSource {
  Future<List<Pedido>> getPedidos();
  Future<void> addPedido(Pedido pedido);
}
