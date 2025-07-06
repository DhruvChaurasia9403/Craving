class Category {
  final String id;
  final String name;
  final String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'].toString(),
      name: json['title'] ?? 'No Name',
      image: json['mediaurls']?['images']?[0]?['default'] ?? '',
    );
  }

}
//By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403