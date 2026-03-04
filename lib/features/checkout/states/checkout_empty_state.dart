import 'package:flutter/material.dart';

class CheckoutEmptyState extends StatelessWidget {
  const CheckoutEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Seu carrinho está vazio",
              style: TextStyle(fontSize: 18),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/products');
              },
              child: const Text('Ver Produtos'))
        ],
      ),
    );
  }
}
