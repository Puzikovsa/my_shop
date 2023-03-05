import 'package:flutter/material.dart';
import 'package:my_shop/providers/products_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_products_item.dart';
import 'edit_product_page.dart';

class UserProductsPage extends StatelessWidget{
  static const String route = '/user-products';

  const UserProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Мои продукты'),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: products.items.length,
            itemBuilder: (_, index) =>
                 UserProductsItem(product: products.items[index],
                 ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(EditProductPage.route);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}