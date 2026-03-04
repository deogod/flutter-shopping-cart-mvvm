import '../../../../achitecture.dart';

class Pedido {
  final String id;
  final double price;
  final String ownerEmail;
  final List<Item> items;

  Pedido({
    required this.id,
    required this.price,
    required this.ownerEmail,
    required this.items,
  });
}
