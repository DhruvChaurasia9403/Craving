class VendorModel {
  final String id;
  final String name;
  final String image;
  final String address;

  VendorModel({
    required this.id,
    required this.name,
    required this.image,
    required this.address,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'address': address,
    };
  }
}
