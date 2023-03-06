import 'package:flutter/material.dart';
import 'package:my_shop/providers/product.dart';
import 'package:my_shop/providers/products_provider.dart';
import 'package:provider/provider.dart';

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

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if(_isInit){
      final productId = ModalRoute.of(context)!.settings.arguments as String?;
      if(productId != null){
        _newProduct = Provider.of<Products>(
            context, listen: false).findById(productId);
        _imageController.text = _newProduct.imageURL;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
                initialValue: _newProduct.title,
                decoration: const InputDecoration(
                  labelText: 'Название товара',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (newvalue) {
                  _newProduct = Product(
                      id: _newProduct.id,
                      title: newvalue ?? _newProduct.title,
                      description: _newProduct.description,
                      price:_newProduct.price,
                      imageURL: _newProduct.imageURL);
                },
                validator: (value) {
                  if(value == null || value.isEmpty){
                   return 'Введите название товара';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _newProduct.price > 0 ?
                _newProduct.price.toString() : '',
                decoration: const InputDecoration(
                  labelText: 'Стоимость',
                ),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSaved: (newvalue) {
                  _newProduct = Product(
                      id: _newProduct.id,
                      title: _newProduct.title,
                      description: _newProduct.description,
                      price: double.tryParse(newvalue!) ?? _newProduct.price,
                      imageURL: _newProduct.imageURL);
                },
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'Введите цену товара';
                  }
                  if(double.tryParse(value) == 0){
                    return 'Введите корректное число';
                  }
                  if(double.tryParse(value)! < 0){
                    return 'Введите корректную стоимость';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _newProduct.description,
                decoration: const InputDecoration(
                  labelText: 'Описание товара',
                ),
                focusNode: _descriptionFocusNode,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (newvalue) {
                  _newProduct = Product(
                      id: _newProduct.id,
                      title: _newProduct.title,
                      description: newvalue?? _newProduct.description,
                      price: _newProduct.price,
                      imageURL: _newProduct.imageURL);
                },
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'Введите описание товара';
                  }
                  if(value.length < 10){
                    return 'Описание должно быть длиннее 10 символов';
                  }
                  return null;
                },
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
                        onSaved: (newvalue) {
                          _newProduct = Product(
                              id: _newProduct.id,
                              title: _newProduct.title,
                              description: _newProduct.description,
                              price: _newProduct.price,
                              imageURL: newvalue ?? _newProduct.imageURL);
                        },
                        onEditingComplete: () {
                          setState(() {
                          });
                        },
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return 'Введите ссылку на фотографию товара';
                          }
                          if(!value.startsWith('http:/')
                              && (!value.startsWith('https:/')
                          )){
                            return 'Введите корректную ссылку';
                          }
                          if(!value.endsWith('.jpeg')
                              && !value.endsWith('jpg')
                                  && !value.endsWith('png')
                              ){
                            return 'Введите корректную ссылку';
                          }
                          return null;
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
          if(_key.currentState!.validate()) {
            _key.currentState!.save();
            if(_newProduct.id == null) {
              Provider.of<Products>(context, listen: false).addProduct(
                  _newProduct);
            }else{
              Provider.of<Products>(context, listen: false).updateProduct(
                  _newProduct.id!, _newProduct);
            }
            Navigator.of(context).pop();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
