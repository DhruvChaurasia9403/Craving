import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/category_model.dart';

class CategoryRepository {
  final String _endpoint = 'https://example.com/api/categories'; // Replace with actual endpoint

  Future<List<CategoryModel>> getCategories() async {
    final response = await http.get(Uri.parse(_endpoint));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
