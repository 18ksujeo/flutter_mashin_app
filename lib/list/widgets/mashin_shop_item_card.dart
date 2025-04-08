import 'package:flutter/material.dart';
import 'package:flutter_mashin_app/list/logic/mashin_shop_item.dart';
class MashinShopItemCard extends StatelessWidget {
  final MashinShopItem item;

  const MashinShopItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product_detail',
          arguments: {
            'productName': item.name,
            'imageUrl': item.imageAssetPath,
            'description': item.description?.toString() ?? '',
            'price': item.price,
          },
        );
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              item.imageAssetPath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[700],
                  child: const Icon(Icons.broken_image, color: Colors.white),
                );
              },
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.name,
            style: const TextStyle(color: Colors.white, fontSize: 10),
            textAlign: TextAlign.center,
          ),
          Text(
            '가격 ${item.price}원',
            style: const TextStyle(color: Colors.white, fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
