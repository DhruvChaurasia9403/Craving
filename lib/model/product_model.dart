class ProductModel {
  final int id;
  final String name;
  final String image;
  final double price;
  final int vendorId;
  final int categoryId;
  final String description;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.vendorId,
    required this.categoryId,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: (json['price'] as num).toDouble(),
      vendorId: json['vendor_id'],
      categoryId: json['category_id'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'price': price,
    'vendor_id': vendorId,
    'category_id': categoryId,
    'description': description,
  };
}
