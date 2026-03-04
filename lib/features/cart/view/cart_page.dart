import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/features/cart/view/states/cart_error_state.dart';
import 'package:flutter_shopping_cart_mvvm/features/cart/view/states/cart_initial_state.dart';
import 'package:flutter_shopping_cart_mvvm/features/cart/view/states/cart_loading_state.dart';
import 'package:flutter_shopping_cart_mvvm/features/cart/view/states/cart_success_state.dart';
import 'package:flutter_shopping_cart_mvvm/features/cart/view_model/cart_view_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await context.read<CartViewModel>().loadCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Cart ', style: TextStyle(color: Colors.white)),
              Text(
                  'Total: \$${context.watch<CartViewModel>().cart.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white))
            ],
          ),
          backgroundColor: Colors.black,
        ),
        body: Consumer<CartViewModel>(
          builder: (context, viewModel, child) {
            switch (viewModel.status) {
              case CartStatus.initial:
                return const CartInitialState();
              case CartStatus.loading:
                return const CartLoadingState();
              case CartStatus.error:
                return const CartErrorState();
              case CartStatus.success:
                return CartSuccessState(itens: viewModel.cart.items);
            }
          },
        ));
  }
}
