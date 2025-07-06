// product_model.dart
class Product {
  final int id;
  final String name;
  final String detail;
  final double price;
  final String image;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.detail,
    required this.price,
    required this.image,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final categoryList = json['categories'] as List<dynamic>?;
    final category = (categoryList != null && categoryList.isNotEmpty)
        ? categoryList.first['title'] as String? ?? 'Unknown'
        : 'Unknown';

    return Product(
      id: json['id'],
      name: json['title'],
      detail: json['detail'] ?? '',
      price: (json['price'] as num).toDouble(),
      image: json['mediaurls']?['images']?[0]?['default'] ?? '',
      category: category,
    );
  }
}