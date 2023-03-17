import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:provider/provider.dart';
import '../pages/product_detail_page.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            color: Theme.of(context).colorScheme.secondary,
            icon: Icon(
              (product.isFavourite ? Icons.favorite : Icons.favorite_border),
            ),
            iconSize: 20,
            onPressed: () {
              product.changeFavouriteStatus();
              if (product.isFavourite) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Товар добавлен в избранные',
                    textAlign: TextAlign.center,),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Товар удален из избранных',
                      textAlign: TextAlign.center,
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
          trailing: IconButton(
            color: Theme.of(context).colorScheme.secondary,
            icon: const Icon(Icons.shopping_cart),
            iconSize: 20,
            onPressed: () {
              cart.addProductToCart(product);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Товар добавлен в корзину'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                      label: 'ОТМЕНА',
                      onPressed: () {
                        cart.deleteSingleProduct(product.id!);
                      }),
                ),
              );
            },
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetailPage.route, arguments: product.id);
          },
          child: Image.network(
            product.imageURL,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
