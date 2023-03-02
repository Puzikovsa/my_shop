import 'package:flutter/material.dart';
import 'package:my_shop/providers/orders.dart' show Orders;
import 'package:my_shop/widgets/order_item.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';

class OrdersPage extends StatelessWidget {
  static String rout = '/orders';

  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('мои заказы'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orders.orders.length,
        itemBuilder: (context, index) => OrderItem(
          order: orders.orders[index],
        ),
      ),
    );
  }
}


