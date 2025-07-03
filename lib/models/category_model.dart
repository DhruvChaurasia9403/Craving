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
    return Category( //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
      id: json['id'].toString(),
      name: json['name'],
      image: json['image'],
    );
  }
}
//By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403