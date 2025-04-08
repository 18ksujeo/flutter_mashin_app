// lib/cart/widgets/cart_item_widget.dart
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final String productName;
  final double price;
  final int quantity;

  const CartItemWidget({
    required this.productName,
    required this.price,
    required this.quantity, required Color textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        title: Text(productName),
        subtitle: Text("Price: \$${price.toStringAsFixed(2)} | Quantity: $quantity"),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            // Delete item logic
          },
        ),
      ),
    );
  }
}