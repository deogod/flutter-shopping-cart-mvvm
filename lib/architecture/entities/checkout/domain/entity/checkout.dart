import 'package:flutter_shopping_cart_mvvm/architecture/achitecture.dart';

class CheckoutEntity {
  final CartEntity cart;
  final String userId;
  final double frete;
  final DateTime checkoutDate = DateTime.now();
  late final double totalPrice;

  CheckoutEntity({
    required this.cart,
    required this.userId,
    required this.frete,
  }) {
    totalPrice = cart.totalPrice + frete;
  }
}
