import 'package:flutter_mashin_app/list/logic/mashin_shop_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProductStorage {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // 상품 리스트 저장
  static Future<void> saveProducts(List<Map<String, dynamic>> products) async {
    String encodedProducts = json.encode(products);
    await _prefs.setString('products', encodedProducts);
  }

  // 상품 리스트 불러오기
  static List<Map<String, dynamic>> loadProducts() {
    String? encodedProducts = _prefs.getString('products');
    if (encodedProducts != null) {
      List<dynamic> decoded = json.decode(encodedProducts);
      return List<Map<String, dynamic>>.from(decoded);
    }
    return [];
  }

  static void saveProduct(MashinShopItem item) {}
}