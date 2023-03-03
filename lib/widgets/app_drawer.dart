import 'package:flutter/material.dart';
import 'package:my_shop/pages/user_products_page.dart';

import '../pages/orders_page.dart';

class AppDrawer extends StatelessWidget{
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Добро пожаловать'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Магазин'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Мои заказы'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrdersPage.route);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Мои продукты'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(UserProductsPage.route);
            },
          ),
        ],
      ),
    );
  }



}