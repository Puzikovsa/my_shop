import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {

  final List<Product> _items = [
    Product(
        id: 'p1',
        title: 'Футболка',
        description: 'Самая удобная повседневная одежда',
        price: 580,
        imageURL:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Blue_Tshirt.jpg/250px-Blue_Tshirt.jpg'),
    Product(
        id: 'p2',
        title: 'Брюки',
        description: 'Одежда свободного стиля',
        price: 2480.5,
        imageURL:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Trousers-colourisolated.jpg/170px-Trousers-colourisolated.jpg'),
    Product(
        id: 'p3',
        title: 'Блуза',
        description: 'Одежда для деловой женщины',
        price: 1800.30,
        imageURL:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/A_white_blouse_with_blue_flowers.jpg/220px-A_white_blouse_with_blue_flowers.jpg'),
    Product(
        id: 'p4',
        title: 'Пальто',
        description: 'Классическая верхняя одежда',
        price: 13000,
        imageURL:
            'http://best-guide.ru/wp-content/uploads/2013/10/Covert-Coat-Cordings.jpg'),
    Product(
        id: 'p5',
        title: 'Одежда',
        description: 'лучшая одежда',
        price: 2536.25,
        imageURL:
            'https://st.depositphotos.com/1177973/3041/i/600/depositphotos_30413835-stock-photo-beautiful-girl-with-lots-clothes.jpg'),
  ];

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
    ).catchError((error) {
      throw error;
    })
        .then((response) {
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

  Future<void> setProducts() async{
    const url =
        'https://want-go-home-default-rtdb.europe-west1.firebasedatabase.app/products.json';
    final response = await http.get(Uri.parse(url));

  }
}
