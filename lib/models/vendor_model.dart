class Vendor {
  final String id;
  final String name;
  final String image;
  final String location;
  final double rating;
  final int time;
  final double distance;

  Vendor({
    required this.id,
    required this.name,
    required this.image,
    required this.location,
    required this.rating,
    required this.time,
    required this.distance,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'].toString(),
      name: json['name'] ?? 'Unknown',
      image: json['image'] ?? '',
      location: json['location'] ?? 'Unknown',
      rating: (json['rating'] != null) ? (json['rating'] as num).toDouble() : 0.0,
      time: (json['time'] != null) ? (json['time'] as num).toInt() : 0,
      distance: (json['distance'] != null) ? (json['distance'] as num).toDouble() : 0.0,
    );
  }


}
