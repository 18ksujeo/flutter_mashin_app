import 'package:flutter/material.dart';
import 'package:flutter_mashin_app/details/ui/product_detail_screen.dart';
import 'package:flutter_mashin_app/list/logic/mashin_shop_item.dart';
import 'package:flutter_mashin_app/list/widgets/mashin_app_bar.dart';
import '../widgets/mashin_shop_item_card.dart';
import 'package:flutter_mashin_app/storage/product_storage.dart';
import 'package:uuid/uuid.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<MashinShopItem> allItems = [];
  int _selectedNavIndex = 1;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final products = await ProductStorage.loadProducts();
    setState(() {
      allItems = products.map((product) => MashinShopItem(
        name: product['productName'],
        price: product['price'],
        type: product['type'],
        imageAssetPath: product['imageUrl'], 
        productId: Uuid().v4(), // Generate a unique product ID
      )).toList();
    });
  }

  void _addProduct(MashinShopItem item) {
    setState(() {
      allItems.add(item);
    });
    _saveProducts();
  }

  void _deleteProduct(String productId) {
    setState(() {
      allItems.removeWhere((item) => item.productId == productId);
    });
    _saveProducts();
  }

  Future<void> _saveProducts() async {
    await ProductStorage.saveProducts(allItems.map((item) => {
      'productName': item.name,
      'price': item.price,
      'type': item.type,
      'imageUrl': item.imageAssetPath, 
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
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
              itemCount: allItems.length,
              itemBuilder: (context, index) {
                final item = allItems[index];
                return GestureDetector(
                  onTap: () {
                    final parsedPrice = double.tryParse(item.price.replaceAll(',', '')) ?? 0.0;

                    if (parsedPrice == 0.0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Error parsing price, using default value of 0.")),
                      );
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          productName: item.name,
                          imageUrl: item.imageAssetPath, 
                          description: 'Description of ${item.name}',
                          price: parsedPrice,
                        ),
                      ),
                    ).then((_) {
                      setState(() {
                        // Refresh the list if necessary
                      });
                    });
                  },
                  child: MashinShopItemCard(
                    item: item, onDelete: () {  },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/add_product');
          if (result is Map<String, dynamic>) {
            final newItem = MashinShopItem(
              name: result['name'],
              price: result['price'],
              type: result['type'],
              imageAssetPath: result['image'], 
              productId: Uuid().v4(), // Generate a unique product ID
            );
            _addProduct(newItem);
          }
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}