import 'package:flutter/material.dart';
import 'package:flutter_mashin_app/details/widgets/product_image_section.dart';
import 'package:flutter_mashin_app/details/widgets/product_price_section.dart';
import 'package:flutter_mashin_app/details/widgets/quantity_control.dart';
import 'package:flutter_mashin_app/details/widgets/description_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mashin_app/cart/logic/cart_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productName;
  final String imageUrl;
  final String description;
  final double price;

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
          ProductImageSection(imageUrl: imageUrl), // Optimized image loading
          ProductPriceSection(
            productName: productName,
            description: description,
            price: price,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DescriptionWidget(description: description), // Using DescriptionWidget for product description
          ),
          QuantityControl(
            unitPrice: price,
            imageUrl: imageUrl,
            onAddToCart: (quantity) {
              // Add to Cart action
              Provider.of<CartProvider>(context, listen: false).addItem(
                productName, // Using productName as ID
                productName,
                imageUrl,
                price,
                quantity, // Pass quantity to addItem
              );
              final addedItem = Provider.of<CartProvider>(context, listen: false).items[productName];
              if (addedItem != null) {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => ListTile(
                    title: Text(addedItem.title, style: TextStyle(color: Colors.white)),
                    subtitle: Text('수량: ${addedItem.quantity}개 | 가격: ${addedItem.price * addedItem.quantity}', style: TextStyle(color: Colors.white)),
                    tileColor: Colors.black87,
                  ),
                );
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('상품 $quantity개가 장바구니에 추가되었습니다!', style: TextStyle(color: Colors.white))),
              );
            },
            onBuyNow: (quantity) {
              // Buy Now action
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('상품 $quantity개가 구매되었습니다!', style: TextStyle(color: Colors.white))),
              );
            },
          ),
          SizedBox(height: 16), // Add space between the buttons and the next widget (if needed)
        ],
      ),
    );
  }
}
