import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/vendor_model.dart';

class VendorRepository {
  final String _endpoint = 'https://example.com/api/vendors'; // Replace with actual endpoint

  Future<List<VendorModel>> getVendors() async {
    final response = await http.get(Uri.parse(_endpoint));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => VendorModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load vendors');
    }
  }
}
