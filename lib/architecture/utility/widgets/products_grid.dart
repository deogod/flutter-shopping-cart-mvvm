import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/features/cart/view_model/cart_view_model.dart';
import 'package:provider/provider.dart';

import '../../achitecture.dart';

class ProductsGrid extends StatelessWidget {
  final List<Item> items;
  final ScrollController controller;
  final bool isLoadingMore;

  const ProductsGrid({
    super.key,
    required this.items,
    required this.controller,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemCount: items.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= items.length) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final item = items[index];

        return buildItemCard(item, context);
      },
    );
  }
}

Widget buildItemCard(Item item, BuildContext context) {
  return Consumer<CartViewModel>(
    builder: (context, vm, _) {
      final quantity = vm.getItemQuantity(item);

      return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Image.network(
                    item.image ?? '',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.title ?? 'Não informado',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                'R\$ ${item.price?.toStringAsFixed(2) ?? "0.00"}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              quantity == 0
                  ? SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () async {
                          final success = await vm.addItemToCart(item);

                          if (!success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Limite de itens no carrinho atingido'),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.add),
                        label: const Text(
                          'Adicionar ao carrinho',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              vm.decreaseQuantity(item);
                            },
                          ),
                          Text(
                            quantity.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () async {
                              final success = await vm.addItemToCart(item);

                              if (!success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Limite de itens no carrinho atingido'),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      );
    },
  );
}
