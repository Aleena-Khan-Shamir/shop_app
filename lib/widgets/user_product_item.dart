import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/screens/edit_screen.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading:
              CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
          title: Text(product.title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, EditScreen.routeName,
                        arguments: product.id);
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    try {
                      Provider.of<Products>(context, listen: false)
                          .deletProduct(product.id);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('${product.title} has been deleted!')));
                    } catch (_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Deleting failed!')));
                    }
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ))
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
