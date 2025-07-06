import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductRepository {
  Future<List<Product>> fetchProducts(int vendorId, List<int> categoryIds) async {
    // Create a list of futures, one for each category
    final futures = categoryIds.map((catId) async {
      final response = await http.get(Uri.parse(
        'https://deligo.vtlabs.dev/api/products?category=$catId&page=1&per_page=15&vendor=$vendorId',
      ));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final productsJson = jsonData['data'] as List<dynamic>;
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products for category $catId');
      }
    }).toList();

    // Wait for all requests to complete in parallel
    final results = await Future.wait(futures);

    // Flatten the list of lists into a single list
    return results.expand((x) => x).toList();
  }
}