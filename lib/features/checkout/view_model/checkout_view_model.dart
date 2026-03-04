import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/features/cart/view_model/cart_view_model.dart';
import '../../../architecture/achitecture.dart';
import '../../products/products_page.dart';

enum CheckoutState {
  initial,
  loading,
  success,
  error,
  empty,
}

class CheckoutViewModel extends ChangeNotifier {
  final CartService cartManager;
  final DoCheckoutUseCase doCheckoutUseCase;
  final CartViewModel cartViewModel;

  CheckoutViewModel({
    required this.cartManager,
    required this.doCheckoutUseCase,
    required this.cartViewModel,
  });

  CheckoutState _state = CheckoutState.initial;
  CheckoutState get state => _state;

  CartEntity _cart = CartEntity(items: []);
  CartEntity get cart => _cart;

  CheckoutEntity? _checkout;
  CheckoutEntity? get checkout => _checkout;

  double frete = 0;

  void setState(CheckoutState state) {
    _state = state;
    notifyListeners();
  }

  void updateFrete() {
    frete = (Random().nextDouble() * 100);
  }

  Future<void> getCart() async {
    await cartManager.loadCart();
    _cart = cartManager.cart;
    notifyListeners();
  }

  Future<void> doCheckout() async {
    setState(CheckoutState.loading);

    if (_cart.items.isEmpty) {
      setState(CheckoutState.empty);
      return;
    }

    _checkout = CheckoutEntity(cart: _cart, userId: "user123", frete: frete);
    notifyListeners();

    final result = await doCheckoutUseCase(_checkout!);
    result.fold((failure) {
      setState(CheckoutState.error);
    }, (success) {
      cartViewModel.clearCart();
      notifyListeners();
      setState(CheckoutState.success);
    });
  }

  void cancelCheckout(BuildContext context) {
    cartViewModel.clearCart();
    notifyListeners();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const ProductsPage()),
      (route) => false,
    );
  }
}
