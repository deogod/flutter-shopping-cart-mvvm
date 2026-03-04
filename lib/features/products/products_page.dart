import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart_mvvm/features/products/states/products_error_state.dart';
import 'package:flutter_shopping_cart_mvvm/features/products/states/products_loading_state.dart';
import 'package:flutter_shopping_cart_mvvm/features/products/view_model/products_view_model.dart';
import 'package:provider/provider.dart';

import '../../architecture/achitecture.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // chama depois que o widget monta
    Future.microtask(() {
      context.read<ProductsViewModel>().loadItems();
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ProductsViewModel>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          cartButton(context, context.watch<ProductsViewModel>().totalItems),
      body: Consumer<ProductsViewModel>(
        builder: (context, vm, _) {
          switch (vm.status) {
            case ProductsStatus.loading:
              return const ProductsLoadingState();

            case ProductsStatus.error:
              return const ProductsErrorState();

            case ProductsStatus.success:
              return ProductsGrid(
                  items: vm.items,
                  controller: _scrollController,
                  isLoadingMore: vm.isLoadingMore);

            case ProductsStatus.initial:
              return const SizedBox(); // ou loading
          }
        },
      ),
    );
  }
}
