import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mashin_app/cart/logic/cart_provider.dart';

class PaymentButton extends StatelessWidget {
  final double totalAmount;

  const PaymentButton({
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Provider.of<CartProvider>(context, listen: false).checkout();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('결제가 완료되었습니다!')),
        );
        Navigator.pushNamed(context, '/purchase_history');
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
