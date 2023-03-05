import 'package:flutter/material.dart';
import 'package:my_shop/providers/product.dart';

class EditProductPage extends StatefulWidget {
  static const String route = '/edit-product';

  const EditProductPage({super.key});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageController = TextEditingController();
  final _key = GlobalKey<FormState>();

  Product _newProduct = Product(
      id:null,
      title: '',
      description: '',
      price: -1,
      imageURL: '');

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Изменение товара'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _key,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Название товара',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Стоимость',
                ),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Описание товара',
                ),
                focusNode: _descriptionFocusNode,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
              ),
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(top: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageController.text.isEmpty ?
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Введите путь до фотографии',
                        textAlign: TextAlign.center,
                        ),
                      ],
                    ) :
                    Image.network(_imageController.text,
                    fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                      child: TextFormField(
                        controller: _imageController,
                          decoration: const InputDecoration(
                            labelText: 'Ссылка на фотографию',
                      ),
                        onEditingComplete: () {
                          setState(() {
                          });
                        },
                      ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _key.currentState!.save();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
