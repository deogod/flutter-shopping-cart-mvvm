import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/features/checkout/view_model/checkout_view_model.dart';
import 'package:provider/provider.dart';

class CheckoutErrorState extends StatelessWidget {
  const CheckoutErrorState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Erro ao processar o checkout. Tente novamente.'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<CheckoutViewModel>().doCheckout();
            },
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }
}
