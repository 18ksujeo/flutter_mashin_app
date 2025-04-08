import 'package:flutter/material.dart';
import 'package:flutter_mashin_app/cart/widgets/cart_item_widget.dart';
import 'package:flutter_mashin_app/cart/widgets/payment_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mashin_app/cart/logic/cart_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartProvider>(context).items.values.toList();
    double totalAmount = cartItems.fold(0.0, (sum, item) {
      return sum + (item.price * item.quantity);
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
                  productName: cartItems[index].title,
                  price: cartItems[index].price,
                  quantity: cartItems[index].quantity,
                  textColor: Colors.white,
                  onRemove: () {
                    Provider.of<CartProvider>(context, listen: false).removeItem(cartItems[index].id);
                  },
                  imageUrl: cartItems[index].imageUrl,
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

extension on CartProvider {
  void removeItem(String id) {}
}
