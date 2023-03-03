import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class UserProductsPage extends StatelessWidget{
  static const String route = '/user-products';
  const UserProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Мои продукты'),
      ),
      drawer: const AppDrawer(),
      body: Container(),
    );
  }
}