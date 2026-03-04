import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/features/checkout/view_model/checkout_view_model.dart';
import 'package:provider/provider.dart';

class CheckoutInitialState extends StatefulWidget {
  const CheckoutInitialState({super.key});

  @override
  State<CheckoutInitialState> createState() => _CheckoutInitialStateState();
}

class _CheckoutInitialStateState extends State<CheckoutInitialState> {
  @override
  void initState() {
    context.read<CheckoutViewModel>().updateFrete();
    context.read<CheckoutViewModel>().getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<CheckoutViewModel>(
      builder: (context, viewModel, child) {
        final cartItems = viewModel.cart.items;

        return Column(
          children: [
            /// Lista de produtos
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartItems[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: Image.network(
                        cartItem.item.image ?? '',
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                      title: Text(
                        cartItem.item.title ?? 'Produto',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        "Qtd: ${cartItem.quantity}",
                      ),
                      trailing: Text(
                        "R\$ ${(cartItem.item.price! * cartItem.quantity).toStringAsFixed(2)}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),

            /// Resumo do pedido
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey)),
              ),
              child: Column(
                children: [
                  _priceRow("Subtotal", viewModel.cart.totalPrice),
                  const SizedBox(height: 6),
                  _priceRow("Frete", viewModel.frete),
                  const Divider(height: 20),
                  _priceRow(
                    "Total",
                    (viewModel.cart.totalPrice) + viewModel.frete,
                    isTotal: true,
                  ),

                  const SizedBox(height: 16),

                  /// Botão finalizar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<CheckoutViewModel>().doCheckout();
                      },
                      child: const Text("Finalizar Pedido"),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<CheckoutViewModel>()
                            .cancelCheckout(context);
                      },
                      child: const Text("Cancelar Pedido"),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    ));
  }

  Widget _priceRow(String label, double value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 18 : 14,
          ),
        ),
        Text(
          "R\$ ${value.toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 18 : 14,
          ),
        ),
      ],
    );
  }
}
