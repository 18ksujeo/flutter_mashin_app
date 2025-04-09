import 'package:flutter/material.dart';
import 'package:flutter_mashin_app/cart/models/cart_item.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};
  final List<CartItem> _purchaseHistory = [];

  Map<String, CartItem> get items => _items;
  List<CartItem> get purchaseHistory => _purchaseHistory;

  void addItem(String id, String title, String imageUrl, double price, int quantity) {
    if (_items.containsKey(id)) {
      _items.update(
        id,
        (existingItem) => CartItem(
          id: existingItem.id,
          title: existingItem.title,
          imageUrl: existingItem.imageUrl,
          price: existingItem.price,
          quantity: existingItem.quantity + quantity,
        ),
      );
    } else {
      _items.putIfAbsent(
        id,
        () => CartItem(
          id: id,
          title: title,
          imageUrl: imageUrl,
          price: price,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  void checkout() {
    _purchaseHistory.addAll(_items.values);
    _items.clear();
    notifyListeners();
  }

  double get totalPrice {
    return _items.values.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  void removeItem(String productName) {}
}