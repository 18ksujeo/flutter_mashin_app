import 'package:flutter/material.dart';

class QuantityControl extends StatefulWidget {
  final int unitPrice;

  const QuantityControl({super.key, required this.unitPrice});

  @override
  State<QuantityControl> createState() => _QuantityControlState();
}

class _QuantityControlState extends State<QuantityControl> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final int totalPrice = widget.unitPrice * quantity;

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
              Text('총 금액: ₩$totalPrice',
                  style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('구매가 완료되었습니다!')),
                  );
                },
                child: const Text('구매하기'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
