import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_shop/providers/orders.dart' as provider;

class OrderItem extends StatefulWidget {
  final provider.OrderItem order;

  const OrderItem({super.key, required this.order});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('${widget.order.amount.toStringAsFixed(2)} руб.'),
              subtitle: Text(
                DateFormat('dd.MM.yyyy hh:mm').format(widget.order.dateTime),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              ),
            ),
            if (_expanded)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: widget.order.products
                      .map(
                        (product) => Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(product.product.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                                ),
                                Text('${product.product.price} руб',
                                  style: const TextStyle(
                                      fontSize: 16,
                                    color: Colors.grey
                                  ),
                                ),
                                Text(' X ${product.quantity} шт.',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ));
  }
}
