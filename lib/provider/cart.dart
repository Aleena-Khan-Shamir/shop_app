import 'package:flutter/material.dart';

class CartItem {
  String id;
  String title;
  int quantity;
  double price;
  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      // change quantity
      _items.update(
          productId,
          (existingNewValue) => CartItem(
              id: existingNewValue.id,
              title: existingNewValue.title,
              quantity: existingNewValue.quantity + 1,
              price: existingNewValue.price));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }
}
