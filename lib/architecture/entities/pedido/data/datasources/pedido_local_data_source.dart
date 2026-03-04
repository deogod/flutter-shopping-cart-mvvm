import '../../../../achitecture.dart';

class PedidoLocalDataSource implements PedidoDataSource {
  final LocalStorage localStorage;

  PedidoLocalDataSource({required this.localStorage});

  @override
  Future<void> addPedido(Pedido pedido) async {
    await localStorage.saveData(
        StorageKey.PEDIDO, PedidoMapper().toJson(pedido));
  }

  @override
  Future<List<Pedido>> getPedidos() async {
    final data = await localStorage.getDataList(StorageKey.PEDIDO);
    if (data == null) return [];
    return data.map((json) => PedidoMapper().fromJson(json)).toList();
  }
}
