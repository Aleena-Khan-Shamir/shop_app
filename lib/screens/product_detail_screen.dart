import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/products.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});
  static const routeName = '/product_detail';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProducts =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProducts.title),
      ),
    );
  }
}
