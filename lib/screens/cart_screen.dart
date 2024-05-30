import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart' show Cart;
import 'package:shop_app/provider/orders.dart';
import 'package:shop_app/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const routeName = '/cart_screen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

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
                    Chip(
                        label:
                            Text('\$${cart.totalAmount.toStringAsFixed(2)}')),
                    OrderButton(cart: cart)
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
                      productId: cart.items.keys.toList()[index],
                      quantity: cartItem.quantity);
                }),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading=false;
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
        onPressed:widget.cart.totalAmount<=0?null:  ()async {
          setState((){
            _isLoading=true;
          });
        await  Provider.of<Orders>(context, listen: false).addOrder(
              widget.cart.items.values.toList(), widget.cart.totalAmount);
               setState((){
            _isLoading=false;
          });
          widget.cart.clear();
        },
        child:_isLoading?Center(child:CircularProgressIndicator()): const Text('Order Now'));
  }
}
