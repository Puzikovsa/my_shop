import 'package:flutter/material.dart';
import 'package:my_shop/pages/product_detail_page.dart';
import 'package:my_shop/pages/products_overview_page.dart';
import 'package:my_shop/providers/cart.dart';
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
          ProductDetailPage.rout :
          (context) => const ProductDetailPage(),
        },
      ),
    );
  }
}

