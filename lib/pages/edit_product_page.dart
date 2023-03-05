import 'package:flutter/material.dart';

class EditProductPage extends StatefulWidget{
  static const String route = '/edit-product';
  const EditProductPage({super.key});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Изменение товара'),
      ),
    );
  }
}