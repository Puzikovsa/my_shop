import 'package:flutter/foundation.dart';
import 'package:my_shop/providers/product.dart';

class Cart with ChangeNotifier{

  final Map<String, CartItem> _order = {};

  int get cartItemCount => _order.length;

  double get totalAmount{
    double result = 0;
    for (var cartItem in _order.values) {
      result += cartItem.price;
    }
    return result;
  }

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
    notifyListeners();
  }

  void deleteFromCart(String productId){
    _order.remove(productId);
    notifyListeners();
  }

  void cartClear(){
    _order.clear();
    notifyListeners();
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
