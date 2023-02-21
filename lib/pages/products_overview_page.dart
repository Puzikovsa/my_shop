import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

class ProductsOverviewPage extends StatelessWidget{
  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Товары'),
      ),
      body: const ProductsGrid(),
    );
  }
}