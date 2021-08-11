import 'dart:convert';
import 'package:flutter/material.dart';

class ResultModel with ChangeNotifier {
  final String id;
  final String name;
  final int balance;
  final String typename;
  final List<Offer> offers;

  ResultModel({
    this.id,
    this.name,
    this.balance,
    this.typename,
    this.offers,
  });

  factory ResultModel.fromRawJson(String str) => ResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        balance: json["balance"] == null ? null : json["balance"],
        typename: json["__typename"] == null ? null : json["__typename"],
        offers: json["offers"] == null ? null : List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "balance": balance == null ? null : balance,
        "__typename": typename == null ? null : typename,
        "offers": offers == null ? null : List<dynamic>.from(offers.map((x) => x.toJson())),
      };
}

class Offer with ChangeNotifier {
  final String id;
  final int price;
  final String typename;
  final Product product;

  Offer({
    this.id,
    this.price,
    this.typename,
    this.product,
  });

  factory Offer.fromRawJson(String str) => Offer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"] == null ? null : json["id"],
        price: json["price"] == null ? null : json["price"],
        typename: json["__typename"] == null ? null : json["__typename"],
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "price": price == null ? null : price,
        "__typename": typename == null ? null : typename,
        "product": product == null ? null : product.toJson(),
      };
}

class Product {
  final String id;
  final String name;
  final String description;
  final String image;
  final String typename;

  Product({
    this.id,
    this.name,
    this.description,
    this.image,
    this.typename,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        image: json["image"] == null ? null : json["image"],
        typename: json["__typename"] == null ? null : json["__typename"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "image": image == null ? null : image,
        "__typename": typename == null ? null : typename,
      };
}
