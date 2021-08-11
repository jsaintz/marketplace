import 'package:nu_conta_marketplace/src/model/cart_item_model.dart';

class OrderModel {
  final String id;
  final double total;
  final List<CartItemModel> products;
  final DateTime date;

  OrderModel({
    this.id,
    this.total,
    this.products,
    this.date,
  });
}
