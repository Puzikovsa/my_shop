import 'package:flutter/material.dart';
import 'package:my_shop/pages/cart_page.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:my_shop/providers/products_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
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
  bool _showOnlyFavourites = false;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Products>(context, listen: false).setProducts().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

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
            itemBuilder: (_) => [
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
            builder: (context, cart, child) => Badge(
              value: cart.cartItemCount.toString(),
              child: child!,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CartPage.route);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
        centerTitle: true,
        title: const Text('Товары'),
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(
              showFavourite: _showOnlyFavourites,
            ),
    );
  }
}
