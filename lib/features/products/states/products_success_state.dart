import 'package:flutter/material.dart';

import '../../../architecture/achitecture.dart';

class ProductsSuccessState extends StatelessWidget {
  final List<Item> items;

  const ProductsSuccessState({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ProductsGrid(
      items: items,
      controller: ScrollController(),
      isLoadingMore: false,
    );
  }
}
