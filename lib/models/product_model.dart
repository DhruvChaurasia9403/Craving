class Product {
  final String id;
  final String name;
  final String image;
  final double price;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'],
      image: json['image'],
      price: (json['price'] is double)
          ? json['price']
          : double.tryParse(json['price'].toString()) ?? 0.0,
      category: json['category'] ?? '',
    );
  }
}
