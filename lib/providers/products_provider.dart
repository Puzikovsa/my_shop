import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items => _items;

  List<Product> get favouriteItems =>
      _items.where((product) => product.isFavourite).toList();

  Product findById(String id) =>
      _items.firstWhere((product) => product.id == id);

  Future<void> addProduct(Product product) async {
    const url =
        'https://want-go-home-default-rtdb.europe-west1.firebasedatabase.app/products.json';
    return await http
        .post(
      Uri.parse(url),
      body: json.encode({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageURL': product.imageURL,
        'isFavourite': product.isFavourite,
      }),
      )
        .catchError((error) {
      throw error;
    }).then((response) {
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageURL: product.imageURL);
      _items.add(newProduct);
      notifyListeners();
    });
  }

  void updateProduct(String id, Product newProduct) {
    final productIndex = _items.indexWhere((product) => product.id == id);
    _items[productIndex] = newProduct;
    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  Future<void> setProducts() async {
    const url =
        'https://want-go-home-default-rtdb.europe-west1.firebasedatabase.app/products.json';
    try {
      final response = await http.get(Uri.parse(url));
      final extractProducts = json.decode(response.body) as Map<String,
          dynamic>;
      List<Product> loadedProducts = [];

      extractProducts.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageURL: prodData['imageURL'],
            isFavourite: prodData['isFavourite'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error){
      rethrow;
    }
  }
}
