import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../features/cart/view_model/cart_view_model.dart';
import '../../../features/products/view_model/products_view_model.dart';

Widget cartButton(BuildContext context, int totalItems) {
  return Consumer<CartViewModel>(
    builder: (context, vm, _) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart').then((_) {
                context.read<ProductsViewModel>().loadItems();
              });
            },
            child: const Icon(Icons.shopping_cart),
          ),
          if (vm.cart.items.isNotEmpty)
            Positioned(
              right: -2,
              top: -2,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.red,
                child: Text(
                  vm.cart.items.length.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      );
    },
  );
}
