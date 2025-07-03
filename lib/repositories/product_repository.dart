import 'dart:convert';
import 'dart:async';
import '../models/product_model.dart';

class ProductRepository {
  Future<List<Product>> getProducts(String vendorId) async {
    await Future.delayed(const Duration(seconds: 2));

    const sampleJson = '''
[
  {
    "id": "31",
    "name": "Paneer Tikka",
    "price": 180.0,
    "category": "Starters",
    "image": "https://b.zmtcdn.com/data/pictures/chains/0/550/a846245f8d300f74b0466b5e27d56c66.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A"
  },
  {
    "id": "32",
    "name": "Chicken Tikka",
    "price": 200.0,
    "category": "Starters",
    "image": "https://b.zmtcdn.com/data/pictures/chains/0/550/09305fb365cbfac907d71b53f00a24e9.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A"
  },
  {
    "id": "33",
    "name": "Hara Bhara Kebab",
    "price": 150.0,
    "category": "Starters",
    "image": "https://b.zmtcdn.com/data/pictures/chains/0/550/a846245f8d300f74b0466b5e27d56c66.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A"
  },
  {
    "id": "34",
    "name": "Tandoori Aloo",
    "price": 170.0,
    "category": "Starters",
    "image": "https://b.zmtcdn.com/data/pictures/chains/0/550/a846245f8d300f74b0466b5e27d56c66.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A"
  },
  {
    "id": "35",
    "name": "Mushroom Tikka",
    "price": 190.0,
    "category": "Starters",
    "image": "https://b.zmtcdn.com/data/pictures/chains/0/550/09305fb365cbfac907d71b53f00a24e9.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A"
  },

  {
    "id": "36",
    "name": "Butter Chicken",
    "price": 250.0,
    "category": "Main Course",
    "image": "https://b.zmtcdn.com/data/pictures/chains/9/18198449/33abf1f8220d11bda0ed639865e63b81.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A"
  },
  {
    "id": "37",
    "name": "Paneer Butter Masala",
    "price": 220.0,
    "category": "Main Course",
    "image": "https://b.zmtcdn.com/data/pictures/5/19841065/d86fdfcc364c293f340f660b41f50190.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A"
  },
  {
    "id": "38",
    "name": "Dal Makhani",
    "price": 180.0,
    "category": "Main Course",
    "image": "https://b.zmtcdn.com/data/pictures/chains/9/18198449/33abf1f8220d11bda0ed639865e63b81.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A"
  },
  {
    "id": "39",
    "name": "Shahi Paneer",
    "price": 230.0,
    "category": "Main Course",
    "image": "https://b.zmtcdn.com/data/pictures/5/19841065/d86fdfcc364c293f340f660b41f50190.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A"
  },
  {
    "id": "40",
    "name": "Kadai Paneer",
    "price": 210.0,
    "category": "Main Course",
    "image": "https://b.zmtcdn.com/data/pictures/5/19841065/d86fdfcc364c293f340f660b41f50190.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A"
  },
  {
    "id": "41",
    "name": "Egg Curry",
    "price": 190.0,
    "category": "Main Course",
    "image": "https://b.zmtcdn.com/data/pictures/chains/9/18198449/33abf1f8220d11bda0ed639865e63b81.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A"
  },
  {
    "id": "42",
    "name": "Chole Masala",
    "price": 160.0,
    "category": "Main Course",
    "image": "https://b.zmtcdn.com/data/pictures/5/19841065/d86fdfcc364c293f340f660b41f50190.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A"
  },

  {
    "id": "43",
    "name": "Gulab Jamun",
    "price": 60.0,
    "category": "Dessert",
    "image": "https://b.zmtcdn.com/data/pictures/chains/0/550/ecafa162e3f8424b70c79490da95b68a.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A"
  },
  {
    "id": "44",
    "name": "Rasmalai",
    "price": 80.0,
    "category": "Dessert",
    "image": "https://b.zmtcdn.com/data/pictures/chains/0/550/ecafa162e3f8424b70c79490da95b68a.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A"
  },
  {
    "id": "45",
    "name": "Chocolate Brownie",
    "price": 90.0,
    "category": "Dessert",
    "image": "https://b.zmtcdn.com/data/pictures/chains/0/550/ecafa162e3f8424b70c79490da95b68a.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A"
  }
]
''';

    final List decoded = jsonDecode(sampleJson);
    return decoded.map((e) => Product.fromJson(e)).toList();
  }
}
