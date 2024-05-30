import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shop_app/provider/auth.dart';
import 'package:shop_app/provider/cart.dart';
import 'package:shop_app/provider/product.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.product});
  final Product product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, ProductDetailScreen.routeName,
            arguments: widget.product.id),
        child: GridTile(
          footer: GridTileBar(
              backgroundColor: Colors.black54,
              leading: GestureDetector(
                  onTap: () async {
                    final oldStatus = widget.product.isFavorite;
                    setState(() {
                      widget.product.isFavorite = !widget.product.isFavorite;
                    });
                    final url = Uri.parse(
                        'https://flutterrestapi-17c56-default-rtdb.firebaseio.com/userFavorites/${auth.userId}/${widget.product.id}.json?auth=${auth.token}');
                    try {
                      await http.put(url,
                          body: json.encode(widget.product.isFavorite));
                    } catch (error) {
                      widget.product.isFavorite = oldStatus;
                      setState(() {});
                    }
                  },
                  child: Icon(widget.product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border)),
              title: Text(widget.product.title, textAlign: TextAlign.center),
              trailing: GestureDetector(
                  onTap: () {
                    cart.addItem(widget.product.id, widget.product.title,
                        widget.product.price);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Added  ${widget.product.title} to cart'),
                      action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            cart.removeSingleItem(widget.product.id);
                          }),
                    ));
                  },
                  child: const Icon(Icons.shopping_cart))),
          child: Hero(
              tag: widget.product.id,
              child: Image.network(widget.product.imageUrl, fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
