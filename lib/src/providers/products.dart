import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:nu_conta_marketplace/src/model/result_model.dart';

class ProductsProvider with ChangeNotifier {
  List<Offer> _items;

  set items(List<Offer> value) => _items = value;

  List<Offer> get items => _items;

  int get itemCount => _items.length;

  void deleteProduct(String id) {
    final index = _items.indexWhere((prod) => prod.id == prod.id);
    if (index >= 0) {
      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    }
  }
}
