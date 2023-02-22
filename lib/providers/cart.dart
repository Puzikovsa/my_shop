import 'package:flutter/foundation.dart';
import 'package:my_shop/providers/product.dart';

class Cart with ChangeNotifier{

  final Map<String, CartItem> _order = {};

  int get cartItemCount => _order.length;

  Map <String, CartItem> get order => _order;

  void addProductToCart(Product product){
    if(_order.containsKey(product.id)) {
      _order.update(product.id, (cartItem) =>
          CartItem(cartItem.id, product, cartItem.quantity + 1));
    } else {
      _order.putIfAbsent(product.id, () =>
          CartItem(DateTime.now().toString(), product, 1),
      );
    }
  }
}

class CartItem {

  final String id;
  final Product product;
  final int quantity;
  late final double price;

  CartItem(this.id, this.product, this.quantity)
  {price = product.price * quantity;}
}
