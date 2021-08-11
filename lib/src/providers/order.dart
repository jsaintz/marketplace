import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:nu_conta_marketplace/src/model/order_model.dart';
import 'package:nu_conta_marketplace/src/providers/cart.dart';

class OrdersProvider with ChangeNotifier {
  List<OrderModel> _items = [];

  List<OrderModel> get items => [..._items];

  int get itemsCount => _items.length;

  void addOrder(CartProvider cart) {
    _items.insert(
      0,
      OrderModel(
        id: Random().nextDouble().toString(),
        total: cart.totalAmount,
        date: DateTime.now(),
        products: cart.items.values.toList(),
      ),
    );
    notifyListeners();
  }
}
