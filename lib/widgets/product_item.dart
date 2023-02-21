import 'package:flutter/material.dart';
import 'package:my_shop/providers/products_provider.dart';
import 'package:provider/provider.dart';
import '../pages/product_detail_page.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

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
                product.isFavourite ? Icons.favorite : Icons.favorite_border),
            iconSize: 20,
            onPressed: () {
              product.changeFavouriteStatus();
            },
          ),
          trailing: IconButton(
            color: Theme.of(context).colorScheme.secondary,
            icon: const Icon(Icons.shopping_cart),
            iconSize: 20,
            onPressed: () {},
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetailPage.rout, arguments: product.id);
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
