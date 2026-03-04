import 'package:flutter/material.dart';

import '../../../architecture/achitecture.dart';

enum CartStatus { initial, loading, success, error }

class CartViewModel extends ChangeNotifier {
  final CartService cartManager;

  CartViewModel(this.cartManager);

  CartStatus _status = CartStatus.initial;
  CartStatus get status => _status;

  void setStatus(CartStatus status) {
    _status = status;
    notifyListeners();
  }

  CartEntity _cart = CartEntity(items: []);
  CartEntity get cart => _cart;

  Future<void> loadCart() async {
    setStatus(CartStatus.loading);

    await cartManager.loadCart();

    _cart = cartManager.cart;
    totalItems = _cart.items.length;
    if (totalItems == 0) {
      setStatus(CartStatus.initial);
      return;
    }
    setStatus(CartStatus.success);
  }

  void increaseQuantity(Item item) {
    final updatedCart = _cart.addItem(item);

    _cart = updatedCart;
    totalItems = updatedCart.items.length;

    notifyListeners();
  }

  void decreaseQuantity(Item item) {
    final updatedCart = _cart.removeItem(item);

    _cart = updatedCart;
    totalItems = updatedCart.items.length;

    notifyListeners();
    cartManager.removeItem(item);
  }

  void removeItemCompletely(Item item) {
    final updatedCart = _cart.removeCompletely(item);

    _cart = updatedCart;
    totalItems = updatedCart.items.length;

    notifyListeners();
    cartManager.removeCompletely(item);
  }

  Future<bool> addItemToCart(Item item) async {
    if (!canAddItem(item)) return false;

    _cart = _cart.addItem(item);

    notifyListeners();
    await cartManager.addItem(item);
    return true;
  }

  bool canAddItem(Item item) {
    final itemAlreadyInCart =
        _cart.items.any((cartItem) => cartItem.item.id == item.id);

    if (_cart.items.length >= 10 && !itemAlreadyInCart) {
      return false;
    }

    return true;
  }

  void clearCart() {
    _cart = CartEntity(items: []);
    totalItems = 0;
    notifyListeners();
    cartManager.clear();
  }

  int getItemQuantity(Item item) {
    final index = _cart.items.indexWhere((i) => i.item.id == item.id);

    if (index == -1) return 0;

    return _cart.items[index].quantity;
  }

  int totalItems = 0;
}
