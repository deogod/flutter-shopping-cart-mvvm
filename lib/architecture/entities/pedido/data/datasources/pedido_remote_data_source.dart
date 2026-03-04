// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../../achitecture.dart';

class PedidoRemoteDataSource implements PedidoDataSource {
  final LocalStorage localStorage;
  PedidoRemoteDataSource({
    required this.localStorage,
  });

  @override
  Future<void> addPedido(Pedido pedido) async {
    await localStorage.saveData(
        StorageKey.PEDIDO, PedidoMapper().toJson(pedido));
    return;
  }

  @override
  Future<List<Pedido>> getPedidos() async {
    final data = await localStorage.getDataList(StorageKey.PEDIDO);
    if (data == null) return [];
    return data.map((json) => PedidoMapper().fromJson(json)).toList();
  }
}
