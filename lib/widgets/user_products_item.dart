import 'package:flutter/material.dart';
import 'package:my_shop/providers/product.dart';
import 'package:my_shop/providers/products_provider.dart';
import 'package:provider/provider.dart';
import '../pages/edit_product_page.dart';

class UserProductsItem extends StatelessWidget{
  final Product product;
  const UserProductsItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(product.title),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(product.imageURL),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: () {
                Navigator.of(context).pushNamed(
                    EditProductPage.route, arguments: product.id);
              },
                  icon:  Icon(Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                  ),
              ),
              IconButton(onPressed: () {
                Provider.of<Products>(context, listen: false).
                deleteProduct(product.id!);
              },
                icon:  Icon(Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

}