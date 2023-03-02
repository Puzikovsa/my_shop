import 'package:flutter/material.dart';
import 'package:my_shop/providers/orders.dart';
import 'package:my_shop/widgets/cart_Items.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartPage extends StatelessWidget {
  static const String route = '/cart';

  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Корзина'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Text('Итого'),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '${cart.totalAmount.toStringAsFixed(2)} руб.',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false)
                          .addCartToOrders(
                              cartProducts: cart.order.values.toList(),
                              total: cart.totalAmount);
                      cart.cartClear();
                    },
                    child: const Text('Оформить заказ'),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.order.length,
              itemBuilder: (BuildContext context, int index) => CartItems(
                id: cart.order.values.toList()[index].id,
                title: cart.order.values.toList()[index].product.title,
                productId: cart.order.values.toList()[index].product.id,
                quantity: cart.order.values.toList()[index].quantity,
                price: cart.order.values.toList()[index].price,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
