import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/features/products/view_model/products_view_model.dart';
import 'package:provider/provider.dart';

class ProductsErrorState extends StatelessWidget {
  const ProductsErrorState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text('Ocorreu um erro ao carregar os produtos.'),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () {
            context.read<ProductsViewModel>().loadItems();
          },
          child: const Text('Tentar novamente'),
        ),
      ],
    );
  }
}
