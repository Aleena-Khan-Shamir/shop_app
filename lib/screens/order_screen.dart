import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/orders.dart' show Orders;
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  static const routeName = '/order';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(title: const Text('Your Order')),
        drawer: const AppDrawer(),
        body: ListView.builder(
            itemCount: orderData.orders.length,
            itemBuilder: (_, index) =>
                OrderItems(orderItem: orderData.orders[index])));
  }
}
