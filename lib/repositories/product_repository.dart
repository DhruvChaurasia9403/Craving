import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductRepository {
  final String _baseUrl = 'https://example.com/api/products?vendorId='; // Replace with actual base URL

  Future<List<ProductModel>> getProductsByVendor(String vendorId) async {
    final response = await http.get(Uri.parse('$_baseUrl$vendorId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products for vendor $vendorId');
    }
  }
}
