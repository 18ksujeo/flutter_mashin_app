import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final String productName;
  final double price;
  final int quantity;
  final Color textColor;

  const CartItemWidget({
    required this.productName,
    required this.price,
    required this.quantity,
    required this.textColor,
    required Null Function() onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        title: Text(productName, style: TextStyle(color: Colors.red)),
        subtitle: Text(
          "Price: \$${price.toStringAsFixed(2)} | Quantity: $quantity",
          style: TextStyle(color: Colors.red),
        ),
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
