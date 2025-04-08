import 'package:flutter/material.dart';
import 'package:flutter_mashin_app/details/ui/product_detail_screen.dart';
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

  int _selectedNavIndex = 1;

  @override
  Widget build(BuildContext context) {
    List<MashinShopItem> filteredItems =
        allItems.where((item) => item.type == selectedFilter).toList();

    return Scaffold(
      appBar: const MashinAppBar(automaticallyImplyLeading: false),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                final item = filteredItems[index];
                return GestureDetector(
                  onTap: () {
                    // Handle price parsing
                    final parsedPrice = double.tryParse(item.price.replaceAll(',', ''));
                    final price = parsedPrice ?? 0.0;

                    // If parsing fails, show a SnackBar with an error message
                    if (parsedPrice == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Error parsing price, using default value of 0.")),
                      );
                    }

                    // Navigate to product detail page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          productName: item.name,
                          imageUrl: item.imageAssetPath,
                          description: 'Description of ${item.name}', // Placeholder for description
                          price: price,
                        ),
                      ),
                    );
                  },
                  child: MashinShopItemCard(item: item),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to the add product page
          final result = await Navigator.pushNamed(context, '/add_product');
          if (result != null && result is Map<String, dynamic>) {
            setState(() {
              // Add the new product to the list
              allItems.add(MashinShopItem(
                name: result['name'],
                price: result['price'],
                type: result['type'],
                imageAssetPath: result['image'], // Ensure imageAssetPath is passed correctly
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
