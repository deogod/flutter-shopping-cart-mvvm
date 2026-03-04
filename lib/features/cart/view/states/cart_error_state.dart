import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/cart_view_model.dart';

class CartErrorState extends StatelessWidget {
  const CartErrorState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text('Ocorreu um erro ao carregar o carrinho.'),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () {
            context.read<CartViewModel>().loadCart();
          },
          child: const Text('Tentar novamente'),
        ),
      ],
    );
  }
}
