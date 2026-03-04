import 'package:flutter/material.dart';
import '../../achitecture.dart';

class CartService extends ChangeNotifier {
  final LocalStorage storage;

  CartService(this.storage);

  CartEntity _cart = CartEntity(items: []);

  CartEntity get cart => _cart;

  Future<void> loadCart() async {
    final data = await storage.getData(StorageKey.CART);

    if (data != null) {
      _cart = CartMapper().fromJson(data);
      notifyListeners();
    }
  }

  Future<void> addItem(Item item) async {
    _cart = _cart.addItem(item);

    notifyListeners();

    await _save();
  }

  Future<void> removeItem(Item item) async {
    _cart = _cart.removeItem(item);

    notifyListeners();

    await _save();
  }

  Future<void> removeCompletely(Item item) async {
    _cart = _cart.removeCompletely(item);

    notifyListeners();

    await _save();
  }

  Future<void> clear() async {
    _cart = CartEntity(items: []);

    notifyListeners();

    await storage.saveData(StorageKey.CART, {});
  }

  Future<void> _save() async {
    await storage.saveData(
      StorageKey.CART,
      CartMapper().toJson(_cart),
    );
  }
}
