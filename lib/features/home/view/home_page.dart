import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/features/home/view/states/home_error_state.dart';
import 'package:flutter_shopping_cart_mvvm/features/home/view_model/home_view_model.dart';
import 'package:provider/provider.dart';
import 'states/home_initial_state.dart';
import 'states/home_loading_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home Page', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.status == HomeStatus.success) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!context.mounted) return;
              Navigator.pushReplacementNamed(context, '/products');
            });
          }
          switch (viewModel.status) {
            case HomeStatus.initial:
              return const HomeInitialState();
            case HomeStatus.loading:
              return const HomeLoadingState();
            case HomeStatus.error:
              return const HomeErrorState();
            case HomeStatus.success:
              return const HomeLoadingState();
          }
        },
      ),
    );
  }
}
