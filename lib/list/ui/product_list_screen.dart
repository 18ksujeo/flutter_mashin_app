import 'package:flutter/material.dart';
import 'package:flutter_mashin_app/list/logic/mashin_shop_item.dart';
import 'package:flutter_mashin_app/list/widgets/mashin_app_bar.dart';
import '../widgets/mashin_shop_item_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String selectedFilter = '마신주교';

  final List<MashinShopItem> allItems = [];
  // final List<MashinShopItem> allItems = [
  //   MashinShopItem(
  //     imageAssetPath: 'assets/image/mashin_1.jpg',
  //     name: '이지우 마왕17',
  //     price: '100,000,000',
  //     type: '마신주교',
  //   ),
  //   MashinShopItem(
  //     imageAssetPath: 'assets/image/mashin_2.jpg',
  //     name: '마도사 환웅',
  //     price: '80,000,000',
  //     type: '신도',
  //   ),
  //   MashinShopItem(
  //     imageAssetPath: 'assets/image/mashin_3.jpg',
  //     name: '강림 장로',
  //     price: '50,000,000',
  //     type: '장로회',
  //   ),
  //   MashinShopItem(
  //     imageAssetPath: 'assets/image/mashin_4.jpg',
  //     name: '하늘의 무녀',
  //     price: '70,000,000',
  //     type: '상급무사',
  //   ),
  //   MashinShopItem(
  //     imageAssetPath: 'assets/image/mashin_5.jpg',
  //     name: '도해 무사',
  //     price: '60,000,000',
  //     type: '중급무사',
  //   ),
  //   MashinShopItem(
  //     imageAssetPath: 'assets/image/mashin_6.jpg',
  //     name: '백월 무사',
  //     price: '40,000,000',
  //     type: '하급무사',
  //   ),
  //   MashinShopItem(
  //     imageAssetPath: 'assets/image/mashin_7.jpg',
  //     name: '혈마 첩자',
  //     price: '90,000,000',
  //     type: '혈마첩자',
  //   ),
  // ];

  // List<String> filters = ['신도', '마신주교', '장로회', '상급무사', '중급무사', '하급무사', '혈마첩자'];

  int _selectedNavIndex = 1;

  @override
  Widget build(BuildContext context) {
    List<MashinShopItem> filteredItems =
        allItems.where((item) => item.type == selectedFilter).toList();

    return Scaffold(
      appBar: const MashinAppBar(),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // MashinFilterButtons(
          //   filters: filters,
          //   selectedFilter: selectedFilter,
          //   onFilterSelected: (filter) {
          //     setState(() {
          //       selectedFilter = filter;
          //     });
          //   },
          // ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return MashinShopItemCard(item: filteredItems[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/add_product');
          if (result != null && result is Map<String, dynamic>) {
            setState(() {
              allItems.add(MashinShopItem(
                name: result['name'],
                price: result['price'],
                type: result['type'],
                imageAssetPath: result['image'],
              ));
              selectedFilter = result['type'];
            });
          }
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
