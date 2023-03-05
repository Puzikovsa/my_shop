import 'package:flutter/material.dart';
import 'package:my_shop/pages/cart_page.dart';
import 'package:my_shop/pages/edit_product_page.dart';
import 'package:my_shop/pages/orders_page.dart';
import 'package:my_shop/pages/product_detail_page.dart';
import 'package:my_shop/pages/products_overview_page.dart';
import 'package:my_shop/pages/user_products_page.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:my_shop/providers/orders.dart';
import 'package:my_shop/providers/products_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => Products(),
        ),
        ChangeNotifierProvider(
            create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Магазин',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.purple,
          )
          .copyWith(secondary: Colors.deepOrange),
        ),
        home: const ProductsOverviewPage(),
        routes: {
          ProductDetailPage.route :
          (context) => const ProductDetailPage(),
          CartPage.route :
          (context) => const CartPage(),
          OrdersPage.route:
          (context) => const OrdersPage(),
          UserProductsPage.route:
          (context) => const UserProductsPage(),
          EditProductPage.route:
          (context) => const EditProductPage(),
        },
      ),
    );
  }
}

