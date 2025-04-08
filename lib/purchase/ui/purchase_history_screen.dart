import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mashin_app/cart/logic/cart_provider.dart';
import 'dart:io';

class PurchaseHistoryScreen extends StatelessWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: '마교 ',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: '구매내역',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          final purchases = cartProvider.purchaseHistory;

          if (purchases.isEmpty) {
            return const Center(
              child: Text(
                '아직 구매내역이 없습니다.',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: purchases.length,
            itemBuilder: (context, index) {
              final item = purchases[index];
              return Card(
                color: Colors.white,
                child: ListTile(
                  leading: item.imageUrl.startsWith('http')
                      ? Image.network(item.imageUrl, width: 60, height: 60, fit: BoxFit.cover)
                      : item.imageUrl.startsWith('/')
                          ? Image.file(File(item.imageUrl), width: 60, height: 60, fit: BoxFit.cover)
                          : Image.asset(item.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                  title: Text(item.title, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    '수량: ${item.quantity}개\n가격: \$${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.black87),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
