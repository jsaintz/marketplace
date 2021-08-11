import 'package:flutter/cupertino.dart';
import 'package:nu_conta_marketplace/src/model/cart_item_model.dart';
import 'package:nu_conta_marketplace/src/model/result_model.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItemModel> _items = {};

  Offer productList;

  Map<String, CartItemModel> get items => {..._items};

  int get itemsCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, carItem) {
      total += carItem.price * carItem.quantity;
    });
    return total;
  }

  void addItem(Offer offer) {
    if (_items.containsKey(offer.id)) {
      _items.update(
        offer.id,
        (existingItem) => CartItemModel(
          id: existingItem.id,
          productId: offer.id,
          name: existingItem.name,
          quantity: existingItem.quantity,
          price: existingItem.price,
          image: existingItem.image,
          description: existingItem.description,
        ),
      );
    } else {
      _items.putIfAbsent(
        offer.id,
        () => CartItemModel(
          productId: offer.id,
          id: offer.id,
          name: offer.product.name,
          quantity: 1,
          price: offer.price,
          image: offer.product.image,
          description: offer.product.description,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(productId) {
    if (!_items.containsKey(productId)) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (existingItem) => CartItemModel(
          id: existingItem.productId,
          productId: productId,
          name: existingItem.name,
          quantity: existingItem.quantity - 1,
          price: existingItem.price,
          image: existingItem.image,
          description: existingItem.description,
        ),
      );
    }
  }

  notifyListeners();
}
