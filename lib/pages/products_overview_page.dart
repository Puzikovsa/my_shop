import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:provider/provider.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';

enum FiltersOptions {
  favourite,
  all,
}

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {

  var _showOnlyFavourites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (FiltersOptions value) {
              setState(() {
                if (value == FiltersOptions.all) {
                  _showOnlyFavourites = false;
                } else {
                  _showOnlyFavourites = true;
                }
              });
            },
            itemBuilder: (_) =>
            [
              const PopupMenuItem(
                value: FiltersOptions.favourite,
                child: Text('Только избранные'),
              ),
              const PopupMenuItem(
                value: FiltersOptions.all,
                child: Text('Все'),
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (context, cart, child) =>
                Badge(
                  value: cart.cartItemCount.toString(),
                  child: IconButton(onPressed: () {},
                    icon: const Icon(Icons.shopping_cart),
                  ),
                ),
          ),
        ],
        centerTitle: true,
        title: const Text('Товары'),
      ),
      body: ProductsGrid(showFavourite: _showOnlyFavourites,),
    );
  }
}
