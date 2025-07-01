class VendorModel {
  final int id;
  final String name;
  final String image;
  final String time;
  final double rating;
  final String address;

  VendorModel({
    required this.id,
    required this.name,
    required this.image,
    required this.time,
    required this.rating,
    required this.address,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      time: json['time'],
      rating: (json['rating'] as num).toDouble(),
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'time': time,
    'rating': rating,
    'address': address,
  };
}
