import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/checkout_view_model.dart';

class CheckoutSuccessState extends StatefulWidget {
  const CheckoutSuccessState({super.key});

  @override
  State<CheckoutSuccessState> createState() => _CheckoutSuccessStateState();
}

class _CheckoutSuccessStateState extends State<CheckoutSuccessState> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 100,
          ),
          const SizedBox(height: 16),
          const Text(
            'Checkout realizado com sucesso!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              context.read<CheckoutViewModel>().setState(CheckoutState.initial);
              Navigator.of(context).pushReplacementNamed('/products');
            },
            child: const Text('Voltar para a loja'),
          )
        ],
      ),
    );
  }
}
