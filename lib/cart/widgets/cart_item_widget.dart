import 'package:flutter/material.dart';
import 'dart:io';

class CartItemWidget extends StatelessWidget {
  final String productName;
  final double price;
  final int quantity;
  final Color textColor;
  final String imageUrl;
  final VoidCallback onRemove;

  const CartItemWidget({
    required this.productName,
    required this.price,
    required this.quantity,
    required this.textColor,
    required this.imageUrl,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: imageUrl.startsWith('http')
            ? Image.network(imageUrl, width: 60, height: 60, fit: BoxFit.cover)
            : imageUrl.startsWith('/')
                ? Image.file(File(imageUrl), width: 60, height: 60, fit: BoxFit.cover)
                : Image.asset(imageUrl, width: 60, height: 60, fit: BoxFit.cover),
        title: Text(productName, style: TextStyle(color: Colors.red)),
        subtitle: Text(
          "가격: \$${price.toStringAsFixed(2)} | 수량: $quantity",
          style: TextStyle(color: Colors.red),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
