
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';

class CategoryRepository {
  Future<List<Category>> getCategories() async {
    try {
      final response = await http.get(Uri.parse(
          'https://deligo.vtlabs.dev/api/categories?meta%5Bvendor_type%5D=food&pagination=0'));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        // ✅ decoded is already a List<dynamic>, no need to access decoded['data']
        if (decoded is List) {
          return decoded
              .map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Unexpected category data format');
        }
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Category Error: $e');
    }
  }
}
