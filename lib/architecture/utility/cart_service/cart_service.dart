import '../../achitecture.dart';

class CartService {
  final LocalStorage storage;

  CartService(this.storage);

  CartEntity _cart = CartEntity(items: []);

  CartEntity get cart => _cart;

  Future<void> loadCart() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate loading delay
    final data = await storage.getData(StorageKey.CART);

    if (data != null && data.isNotEmpty) {
      _cart = CartMapper().fromJson(data);
    }
  }

  Future<void> addItem(Item item) async {
    _cart = _cart.addItem(item);

    await _save();
  }

  Future<void> removeItem(Item item) async {
    _cart = _cart.removeItem(item);

    await _save();
  }

  Future<void> removeCompletely(Item item) async {
    _cart = _cart.removeCompletely(item);

    await _save();
  }

  Future<void> clear() async {
    _cart = CartEntity(items: []);

    await storage.saveData(StorageKey.CART, {});
  }

  Future<void> _save() async {
    await storage.saveData(
      StorageKey.CART,
      CartMapper().toJson(_cart),
    );
  }
}
