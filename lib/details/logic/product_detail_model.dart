import 'package:flutter/material.dart';

class ProductDetailModel {
  final String name;
  final String imageUrl;
  final String description;
  final int price;
  final String sellerId;

  ProductDetailModel({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.sellerId,
  });
}
