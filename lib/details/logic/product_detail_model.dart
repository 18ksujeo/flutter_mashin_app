import 'package:flutter/material.dart';

class ProductDetailModel {
  final String name;
  final String imageUrl;
  final String description; // 상품 설명 필수 항목
  final int price;
  final String sellerId;

  ProductDetailModel({
    required this.name,
    required this.imageUrl,
    required this.description, // 상품 설명 필수 항목
    required this.price,
    required this.sellerId,
  });
}
