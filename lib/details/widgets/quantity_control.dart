import 'package:flutter/material.dart';

class QuantityControl extends StatefulWidget {
  final double unitPrice; // Changed from int to double
  final void Function(int) onAddToCart; // Add to Cart callback
  final void Function(int) onBuyNow; // Buy Now callback

  const QuantityControl({
    super.key,
    required this.unitPrice,
    required this.onAddToCart,
    required this.onBuyNow,
  });

  @override
  State<QuantityControl> createState() => _QuantityControlState();
}

class _QuantityControlState extends State<QuantityControl> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final double totalPrice = widget.unitPrice * quantity; // Changed from int to double

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Text('수량',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.remove, color: Colors.white),
                onPressed: () {
                  setState(() {
                    if (quantity > 1) quantity--;
                  });
                },
              ),
              Text('$quantity',
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('총 금액: ₩${totalPrice.toStringAsFixed(2)}', // Updated to format double
                  style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 32), // Added space between total price and buttons
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent),
                onPressed: () {
                  widget.onBuyNow(quantity); // Trigger buy now action
                },
                child: const Text('결제하기', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue),
                onPressed: () {
                  widget.onAddToCart(quantity); // Trigger add to cart action
                  Navigator.pushNamed(context, '/cart');
                },
                child: const Text('장바구니 담기', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          SizedBox(height: 16), // Add space between the buttons and the next widget (if needed)
        ],
      ),
    );
  }
}
