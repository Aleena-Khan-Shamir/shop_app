import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../provider/orders.dart';

class OrderItems extends StatefulWidget {
  const OrderItems({super.key, required this.orderItem});
  final OrderItem orderItem;

  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(widget.orderItem.amount.toStringAsFixed(2)),
            subtitle: Text(DateFormat('dd MM yyyy hh:mm')
                .format(widget.orderItem.dateTime)),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more)),
          ),
          if (_expanded)
            SizedBox(
              height: min(widget.orderItem.products.length * 20.0 + 15, 180),
              child: ListView(
                children: widget.orderItem.products
                    .map((prod) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(prod.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              Text('${prod.quantity}x'),
                              const Spacer(),
                              Text('\$${prod.price}')
                            ],
                          ),
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
