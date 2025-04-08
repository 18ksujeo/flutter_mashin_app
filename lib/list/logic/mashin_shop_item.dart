class MashinShopItem {
  final String imageAssetPath;
  final String name;
  final String price;
  final String type; // ← 필터 구분용

  MashinShopItem({
    required this.imageAssetPath,
    required this.name,
    required this.price,
    required this.type,
  });

  get description => null;

  void toMap() {}
}
