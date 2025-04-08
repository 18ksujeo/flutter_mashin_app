import 'package:flutter/material.dart';

class PaymentButton extends StatelessWidget {
  final double totalAmount;

  const PaymentButton({required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // continuously update
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, // Set the button color to red
      ),
      child: Text(
        "결제하기 - \$${totalAmount.toStringAsFixed(2)}",
        style: TextStyle(color: Colors.white),  // Set the text color to white
      ),
    );
  }
}
