import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MashinShopItem {
  final String id;
  final String name;

  MashinShopItem({required this.id, required this.name});
}

class ProductListProvider with ChangeNotifier {
  List<MashinShopItem> _products = [];

  List<MashinShopItem> get products => _products;

  void addProduct(MashinShopItem product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(String productId) {
    _products.removeWhere((product) => product.id == productId);
    notifyListeners();
  }
}

class ProductListScreen extends StatelessWidget {
  get productListProvider => null;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductListProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Product List'),
        ),
        body: Consumer<ProductListProvider>(
          builder: (context, productListProvider, child) {
            return ListView.builder(
              itemCount: productListProvider.products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(productListProvider.products[index].name),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      productListProvider.removeProduct(productListProvider.products[index].id);
                    },
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add product logic here
            var uuid = Uuid();
            productListProvider.addProduct(MashinShopItem(id: uuid.v4(), name: 'New Product'));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
