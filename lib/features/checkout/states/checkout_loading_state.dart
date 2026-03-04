import 'package:flutter/material.dart';

class CheckoutLoadingState extends StatelessWidget {
  const CheckoutLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
