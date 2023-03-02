import 'package:flutter/material.dart';

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
              Navigator.of(context).pushReplacementNamed(OrdersPage.rout);
            },
          ),
        ],
      ),
    );
  }



}