import 'package:flutter/material.dart';
import 'package:flutter_mashin_app/details/widgets/product_image_section.dart';
import 'package:flutter_mashin_app/details/widgets/product_price_section.dart';
import 'package:flutter_mashin_app/details/widgets/quantity_control.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productName;
  final String imageUrl;
  final String description;
  final int price;

  const ProductDetailScreen({
    super.key,
    required this.productName,
    required this.imageUrl,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('상품 상세', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          ProductImageSection(imageUrl: imageUrl),
          ProductPriceSection(
            productName: productName,
            description: description,
            price: price,
          ),
          QuantityControl(
            unitPrice: price,
            onAddToCart: (quantity) {
              // Add to Cart action
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('상품 $quantity개가 장바구니에 추가되었습니다!')),
              );
            },
            onBuyNow: (quantity) {
              // Buy Now action
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('상품 $quantity개가 구매되었습니다!')),
              );
            },
          ),
          SizedBox(height: 16), // Add space between the buttons and the next widget (if needed)
        ],
      ),
    );
  }
}
