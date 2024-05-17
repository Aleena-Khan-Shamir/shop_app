import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart';

class CartItems extends StatelessWidget {
  const CartItems(
      {super.key,
      required this.id,
      required this.title,
      required this.price,
      required this.quantity,
      required this.productId});
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(productId),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        color: Theme.of(context).colorScheme.error,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: FittedBox(child: Text(price.toString())),
          ),
        ),
        title: Text(title),
        subtitle: Text('\$${(price * quantity)}'),
        trailing: Text('${quantity}x'),
      ),
    );
  }
}
