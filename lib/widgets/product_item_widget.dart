import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart';
import 'package:shop_app/provider/product.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, ProductDetailScreen.routeName,
            arguments: product.id),
        child: GridTile(
          footer: GridTileBar(
              backgroundColor: Colors.black54,
              leading: Consumer<Product>(
                builder: (context, productData, child) => GestureDetector(
                    onTap: () => productData.toggleFavorite(),
                    child: Icon(productData.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border)),
              ),
              title: Text(product.title, textAlign: TextAlign.center),
              trailing: GestureDetector(
                  onTap: () {
                    cart.addItem(product.id, product.title, product.price);
                  },
                  child: const Icon(Icons.shopping_cart))),
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
