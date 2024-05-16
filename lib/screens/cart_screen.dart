import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart' show Cart;
import 'package:shop_app/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const routeName = '/cart_screen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    print(cart);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total',
                        style: Theme.of(context).textTheme.titleMedium),
                    Chip(label: Text('\$${cart.totalAmount}')),
                    ElevatedButton(
                        onPressed: () {}, child: const Text('Order Now'))
                  ]),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (_, index) {
                  final cartItem = cart.items.values.toList()[index];
                  return CartItems(
                      id: cartItem.id,
                      title: cartItem.title,
                      price: cartItem.price,
                      quantity: cartItem.quantity);
                }),
          )
        ],
      ),
    );
  }
}