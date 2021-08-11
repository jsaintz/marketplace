import 'package:flutter/foundation.dart';

class CartItemModel {
  final String id;
  final String name;
  final String productId;
  final int quantity;
  final int price;
  final String image;
  final String description;

  CartItemModel({
    @required this.id,
    @required this.name,
    @required this.productId,
    @required this.quantity,
    @required this.price,
    @required this.image,
    @required this.description,
  });
}
