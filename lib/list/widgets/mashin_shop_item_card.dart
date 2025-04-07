import 'package:flutter/material.dart';
import 'package:flutter_mashin_app/list/logic/mashin_shop_item.dart';
class MashinShopItemCard extends StatelessWidget {
  final MashinShopItem item;

  const MashinShopItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            item.imageAssetPath,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
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
    );
  }
}
