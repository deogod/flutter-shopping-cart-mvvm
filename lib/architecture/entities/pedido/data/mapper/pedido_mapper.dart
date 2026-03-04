import '../../../../achitecture.dart';

class PedidoMapper {
  Pedido fromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'],
      price: json['price'],
      ownerEmail: json['ownerEmail'],
      items: (json['items'] as List)
          .map((item) => ItemMapper().fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson(Pedido pedido) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = pedido.id;
    data['price'] = pedido.price;
    data['ownerEmail'] = pedido.ownerEmail;
    data['items'] =
        pedido.items.map((item) => ItemMapper().toJson(item)).toList();
    return data;
  }
}
