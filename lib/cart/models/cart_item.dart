class CartItem {
  final String id;
  final String title;
  final String imageUrl;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });
}