import 'dart:convert';
import 'dart:async';
import '../models/category_model.dart';

class CategoryRepository {
  Future<List<Category>> getCategories() async {
    await Future.delayed(const Duration(seconds: 2)); // simulate delay

    const sampleJson = '''
[
  {
    "id": "1",
    "name": "Pancakes",
    "image": "https://images.unsplash.com/photo-1598214886806-c87b84b7078b?q=80&w=1925&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  },
  {
    "id": "2",
    "name": "Pizza",
    "image": "https://images.unsplash.com/photo-1613564834361-9436948817d1?q=80&w=743&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  },
  {
    "id": "3",
    "name": "Burger",
    "image": "https://www.foodiesfeed.com/wp-content/uploads/2023/06/burger-with-melted-cheese.jpg"
  },
  {
    "id": "4",
    "name": "Cakes",
    "image": "https://www.foodiesfeed.com/wp-content/uploads/ff-images/2025/06/creamy-key-lime-pie-with-whipped-topping.webp"
  },
  {
    "id": "5",
    "name": "Salad",
    "image": "https://images.unsplash.com/photo-1654458804670-2f4f26ab3154?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  },
  {
    "id": "6",
    "name": "Beverages",
    "image": "https://www.foodiesfeed.com/wp-content/uploads/2023/10/hot-chocolate.jpg"
  },
  {
    "id": "7",
    "name": "South Indian",
    "image": "https://images.pexels.com/photos/20422129/pexels-photo-20422129.jpeg"
  },
  {
    "id": "8",
    "name": "North Indian",
    "image": "https://images.pexels.com/photos/9609835/pexels-photo-9609835.jpeg"
  },
  {
    "id": "9",
    "name": "Chinese",
    "image": "https://www.foodiesfeed.com/wp-content/uploads/ff-images/2025/06/colorful-sushi-roll-held-with-chopsticks.webp"
  }
]
''';


    final List decoded = jsonDecode(sampleJson);
    return decoded.map((e) => Category.fromJson(e)).toList();
  }
}
