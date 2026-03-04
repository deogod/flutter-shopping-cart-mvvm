import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../architecture/achitecture.dart';
import '../../../checkout/checkout_page.dart';
import '../../view_model/cart_view_model.dart';

class CartSuccessState extends StatelessWidget {
  final List<CartItem> itens;

  const CartSuccessState({super.key, required this.itens});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: buildCartList(itens, context)),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green // Cor de fundo verde
                ),
            onPressed: () {
              context.read<CartViewModel>().setStatus(CartStatus.initial);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const CheckoutPage()),
                  (route) => false);
            },
            child: const Text('Finalizar Compra')),
      ],
    );
  }
}

Widget buildCartList(List<CartItem> items, BuildContext context) {
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      if (items.isEmpty) {
        return const Center(child: Text('Carrinho Vazio'));
      }
      final cartItem = items[index];

      return buildCartItem(cartItem, context);
    },
  );
}

Widget buildCartItem(CartItem cartItem, BuildContext context) {
  final item = cartItem.item;

  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          /// IMAGEM
          SizedBox(
            width: 70,
            height: 70,
            child: Image.network(
              item.image ?? '',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image_not_supported),
            ),
          ),

          const SizedBox(width: 12),

          /// INFORMAÇÕES
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// NOME
                Text(
                  item.title ?? 'Produto',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 6),

                /// PREÇO UNITÁRIO
                Text(
                  'Unitário: R\$ ${item.price?.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 13),
                ),

                const SizedBox(height: 4),

                /// SUBTOTAL
                Text(
                  'Subtotal: R\$ ${(item.price! * cartItem.quantity).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),

          /// CONTROLES DE QUANTIDADE
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  context.read<CartViewModel>().increaseQuantity(item);
                },
              ),
              Text(
                cartItem.quantity.toString(),
                style: const TextStyle(fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  context.read<CartViewModel>().decreaseQuantity(item);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  context.read<CartViewModel>().removeItemCompletely(item);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
