import 'package:flutter/material.dart';

class CartItems extends StatelessWidget {
  const CartItems(
      {super.key,
      required this.id,
      required this.title,
      required this.price,
      required this.quantity});
  final String id;
  final String title;
  final double price;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: FittedBox(child: Text(price.toString())),
        ),
      ),
      title: Text(title),
      subtitle: Text('\$${(price * quantity)}'),
      trailing: Text('${quantity}x'),
    );
  }
}
