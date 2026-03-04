import '../../../../achitecture.dart';

class CartEntity {
  List<CartItem> items;

  int get totalItems => items.fold(0, (total, item) => total + item.quantity);

  CartEntity({required List<CartItem> items})
      : items = List.unmodifiable(items);

  double get totalPrice => items.fold(
        0.0,
        (total, cartItem) =>
            total + ((cartItem.item.price ?? 0) * cartItem.quantity),
      );

  CartEntity addItem(Item item) {
    final updatedItems = [...items];

    final index = updatedItems.indexWhere((i) => i.item.id == item.id);

    if (index >= 0) {
      final existing = updatedItems[index];

      updatedItems[index] = CartItem(
        item: existing.item,
        quantity: existing.quantity + 1,
      );
    } else {
      updatedItems.add(
        CartItem(item: item, quantity: 1),
      );
    }

    return CartEntity(items: updatedItems);
  }

  CartEntity removeCompletely(Item item) {
    final updatedItems = items.where((i) => i.item.id != item.id).toList();

    return CartEntity(items: updatedItems);
  }

  CartEntity removeItem(Item item) {
    final updatedItems = [...items];

    final index = updatedItems.indexWhere((i) => i.item.id == item.id);

    if (index >= 0) {
      final existing = updatedItems[index];

      if (existing.quantity > 1) {
        updatedItems[index] = CartItem(
          item: existing.item,
          quantity: existing.quantity - 1,
        );
      } else {
        updatedItems.removeAt(index);
      }
    }

    return CartEntity(items: updatedItems);
  }
}

class CartItem {
  final Item item;
  final int quantity;

  const CartItem({
    required this.item,
    required this.quantity,
  });

  double get subtotal => (item.price ?? 0) * quantity;
}
