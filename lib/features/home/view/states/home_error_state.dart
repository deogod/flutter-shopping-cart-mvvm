import 'package:flutter/material.dart';

class HomeErrorState extends StatelessWidget {
  const HomeErrorState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Ocorreu um erro ao carregar os dados.'),
    );
  }
}
