import 'package:flutter/material.dart';

import '../../../architecture/achitecture.dart';

enum ProductsStatus { initial, loading, success, error }

class ProductsViewModel extends ChangeNotifier {
  final GetItemsUsecase getItemsUsecase;
  final CartService cartService;

  ProductsStatus _status = ProductsStatus.initial;
  ProductsStatus get status => _status;

  List<Item> _items = [];
  List<Item> get items => _items;

  CartEntity _cart = CartEntity(items: []);
  CartEntity get cart => _cart;

  int totalItems = 0;

  // ignore: unused_field
  int _page = 1;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  ProductsViewModel(this.getItemsUsecase, this.cartService);

  void _setStatus(ProductsStatus status) {
    _status = status;
    notifyListeners();
  }

  Future<void> loadItems() async {
    _setStatus(ProductsStatus.loading);

    final result = await getItemsUsecase();

    result.fold(
      (failure) => _setStatus(ProductsStatus.error),
      (items) {
        _items = items;
        _setStatus(ProductsStatus.success);
      },
    );
  }

  Future<void> loadMore() async {
    if (_isLoadingMore) return;

    _isLoadingMore = true;
    notifyListeners();

    _page++;

    final result = await getItemsUsecase(); // idealmente passando página

    result.fold(
      (_) {},
      (newItems) {
        _items.addAll(newItems);
      },
    );

    _isLoadingMore = false;
    notifyListeners();
  }
}
