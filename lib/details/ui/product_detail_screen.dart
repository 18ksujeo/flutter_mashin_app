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
        title: const Text(
          '상품 상세',
          style: TextStyle(color: Colors.white),
        ),
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
          QuantityControl(unitPrice: price),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add to Cart action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  child: const Text('Add to Cart'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Buy Now action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  child: const Text('Buy Now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
