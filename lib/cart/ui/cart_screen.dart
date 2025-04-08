import 'package:flutter/material.dart';
import 'package:flutter_mashin_app/cart/widgets/cart_item_widget.dart';
import 'package:flutter_mashin_app/cart/widgets/payment_button.dart';

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems = [
    {'productName': 'Item 1', 'price': 29.99, 'quantity': 1},
    {'productName': 'Item 2', 'price': 49.99, 'quantity': 2},
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    double totalAmount = cartItems.fold(0.0, (sum, item) {
      return sum + (item['price'] * item['quantity']);
    });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('장바구니', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return CartItemWidget(
                  productName: cartItems[index]['productName'],
                  price: cartItems[index]['price'],
                  quantity: cartItems[index]['quantity'],
                  textColor:
                      Colors
                          .white, // Assuming CartItemWidget can take textColor
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: PaymentButton(totalAmount: totalAmount),
          ),
        ],
      ),
    );
  }
}
