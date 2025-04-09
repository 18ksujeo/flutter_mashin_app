import '../models/purchase_model.dart';

class PurchaseHistoryController {
  final List<PurchaseItem> _purchases = [];

  List<PurchaseItem> get purchases => _purchases;

  void addPurchase(PurchaseItem item) {
    _purchases.add(item);
  }

  void clearHistory() {
    _purchases.clear();
  }
}

class PurchaseItem {
  final String name;
  final int price;
  final DateTime date;

  PurchaseItem({
    required this.name,
    required this.price,
    required this.date,
  });
}
