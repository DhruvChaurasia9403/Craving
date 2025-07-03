import 'dart:convert';
import 'dart:async';
import '../models/vendor_model.dart';

class VendorRepository {
  Future<List<Vendor>> getVendors() async {
    await Future.delayed(const Duration(seconds: 2));
    //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
    const sampleJson = '''
[
  {
    "id": "12",
    "name": "Tandoori Express",
    "image": "https://b.zmtcdn.com/data/pictures/6/20529116/f3d5f21899fbe3e3c881b2ec612f01cc.jpg?fit=around|771.75:416.25&crop=771.75:416.25;*,*",
    "location": "Raj Nagar",
    "rating": 4.5,
    "time": 30,
    "distance": 1.5
  },
  {
    "id": "13",
    "name": "Burger Mania",
    "image": "https://b.zmtcdn.com/data/pictures/6/20529116/2c9ed6fed6b7624e0f8948f4d4a37745.jpg?fit=around|300:273&crop=300:273;*,*",
    "location": "Vasundhara",
    "rating": 4.2,
    "time": 25,
    "distance": 2.1
  },
  {
    "id": "14",
    "name": "Sweet Tooth",
    "image": "https://b.zmtcdn.com/data/pictures/8/20243538/edc38eabd45f38d8903ef591b689938e.jpg?fit=around|771.75:416.25&crop=771.75:416.25;*,*",
    "location": "Indirapuram",
    "rating": 4.8,
    "time": 20,
    "distance": 0.9
  },
  {
    "id": "15",
    "name": "Chinese Bite",
    "image": "https://b.zmtcdn.com/data/pictures/1/18423151/8a1052c2344444809c8988cb47c8e5f3.jpg?fit=around|771.75:416.25&crop=771.75:416.25;*,*",
    "location": "Kavi Nagar",
    "rating": 4.0,
    "time": 35,
    "distance": 2.3
  },
  {
    "id": "16",
    "name": "Pizza Palace",
    "image": "https://b.zmtcdn.com/data/pictures/1/19495371/520c8a9e8cedd2504cad43e4923fe59f.jpg?fit=around|771.75:416.25&crop=771.75:416.25;*,*",
    "location": "Raj Nagar Ext.",
    "rating": 4.3,
    "time": 28,
    "distance": 1.8
  },
  {
    "id": "17",
    "name": "Roller Coaster",
    "image": "https://b.zmtcdn.com/data/pictures/1/18423151/b3321b08d8642bfe72802703e6f0d6b3.jpg?fit=around|300:273&crop=300:273;*,*",
    "location": "Shastri Nagar",
    "rating": 3.9,
    "time": 18,
    "distance": 1.1
  },
  {
    "id": "18",
    "name": "Southy Vibes",
    "image": "https://b.zmtcdn.com/data/pictures/1/19495371/520c8a9e8cedd2504cad43e4923fe59f.jpg?fit=around|771.75:416.25&crop=771.75:416.25;*,*",
    "location": "Model Town",
    "rating": 4.6,
    "time": 24,
    "distance": 2.0
  },
  {
    "id": "19",
    "name": "North Zaika",
    "image": "https://b.zmtcdn.com/data/pictures/1/19495371/f995f19d86082c36e887f2397323699b.jpg?fit=around|300:273&crop=300:273;*,*",
    "location": "Kavi Nagar",
    "rating": 4.4,
    "time": 22,
    "distance": 1.7
  },
  {
    "id": "20",
    "name": "Momo House",
    "image": "https://b.zmtcdn.com/data/pictures/1/18423151/b3321b08d8642bfe72802703e6f0d6b3.jpg?fit=around|300:273&crop=300:273;*,*",
    "location": "Indirapuram",
    "rating": 4.1,
    "time": 27,
    "distance": 2.4
  },
  {
    "id": "21",
    "name": "Choco Heaven",
    "image": "https://b.zmtcdn.com/data/pictures/3/18382353/2904da66b17b3300e23d0e85984b4926.jpg?fit=around|771.75:416.25&crop=771.75:416.25;*,*",
    "location": "Raj Nagar",
    "rating": 4.9,
    "time": 15,
    "distance": 0.7
  }
]
''';

    final List decoded = jsonDecode(sampleJson);
    return decoded.map((e) => Vendor.fromJson(e)).toList();
  }
} //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
