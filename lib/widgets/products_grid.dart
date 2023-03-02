import 'package:flutter/material.dart';
import 'package:my_shop/widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavourite;

  const ProductsGrid({super.key, required this.showFavourite});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        showFavourite ? productsData.favouriteItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
          child: const ProductItem()
      ),
    );
  }
}
