class MashinShopItem {
  final String imageAssetPath;
  final String name;
  final String price;
  final String type; // ← 필터 구분용
  final String productId; // 추가된 필드

  MashinShopItem({
    required this.imageAssetPath,
    required this.name,
    required this.price,
    required this.type,
    required this.productId, // 추가된 필드 초기화
  });

  get description => null;

  Map<String, dynamic> toMap() { // 수정된 메서드
    return {
      'imageAssetPath': imageAssetPath,
      'name': name,
      'price': price,
      'type': type,
      'productId': productId, // 추가된 필드 포함
    };
  }
  
  // 상품 삭제를 위한 메서드
  static void deleteItem(List<MashinShopItem> items, String productId, Function updateUI) {
    items.removeWhere((item) => item.productId == productId);
    updateUI(); // UI 갱신 로직 추가
  }
}
