import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/provider/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  final String authToken;
  final String userId;
  Orders(this.authToken,this.userId, this._orders);
  List<OrderItem> _orders = [];
  List<OrderItem> get orders => _orders;
  Future<void> fetchAndSetOrder() async {
    final url = Uri.parse(
        'https://flutterrestapi-17c56-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData.isEmpty) return;
    final List<OrderItem> loadedProducts = [];
    extractedData.forEach((orderId, orderData) {
      loadedProducts.add(OrderItem(
        id: orderId,
        amount: orderData['amount'],
        dateTime: DateTime.parse(orderData['dateTime']),
        products: (orderData['products'] as List<dynamic>)
            .map((item) => CartItem(
                id: item['id'],
                price: item['price'],
                quantity: item['quantity'],
                title: item['title']))
            .toList(),
      ));
    });
    _orders = loadedProducts.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartOrder, double total) async {
    final url = Uri.parse(
        'https://flutterrestapi-17c56-default-rtdb.firebaseio.com/orders.json?auth=$authToken');
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartOrder
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'price': cp.price,
                    'quantity': cp.quantity
                  })
              .toList(),
        }));
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            products: cartOrder,
            dateTime: timestamp));
    notifyListeners();
  }
}
