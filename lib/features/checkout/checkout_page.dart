import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/features/checkout/states/checkout_empty_state.dart';
import 'package:provider/provider.dart';

import 'states/checkout_error_state.dart';
import 'states/checkout_initial_state.dart';
import 'states/checkout_loading_state.dart';
import 'states/checkout_success_state.dart';
import 'view_model/checkout_view_model.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
        ),
        body: Consumer<CheckoutViewModel>(
          builder: (context, viewModel, child) {
            switch (viewModel.state) {
              case CheckoutState.initial:
                return const CheckoutInitialState();
              case CheckoutState.loading:
                return const CheckoutLoadingState();
              case CheckoutState.error:
                return const CheckoutErrorState();
              case CheckoutState.success:
                return const CheckoutSuccessState();
              case CheckoutState.empty:
                return const CheckoutEmptyState();
            }
          },
        ));
  }
}
