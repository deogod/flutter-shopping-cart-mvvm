import 'package:flutter_shopping_cart_mvvm/architecture/achitecture.dart';

class CheckoutMapper {
  Map<String, dynamic> toJson(CheckoutEntity checkout) {
    return {
      'cart': checkout.cart,
      'userId': checkout.userId,
      'totalPrice': checkout.totalPrice,
      'checkoutDate': checkout.checkoutDate.toIso8601String(),
    };
  }

  CheckoutEntity fromJson(Map<String, dynamic> json) {
    return CheckoutEntity(
      cart: json['cart'],
      userId: json['userId'],
      frete: json['frete'],
    );
  }
}
