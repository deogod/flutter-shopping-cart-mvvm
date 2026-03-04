import 'package:flutter_shopping_cart_mvvm/architecture/achitecture.dart';

class CartMapper {
  CartEntity fromJson(Map<String, dynamic> json) {
    return CartEntity(
      items: (json['items'] as List)
          .map((item) => CartItem(
                item: ItemMapper().fromJson(item['item']),
                quantity: item['quantity'],
              ))
          .toList(),
    );
  }

  Map<String, dynamic> toJson(CartEntity cart) {
    return {
      'items': cart.items
          .map((item) => {
                'item': ItemMapper().toJson(item.item),
                'quantity': item.quantity,
              })
          .toList(),
    };
  }
}
