import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/vendor_model.dart';

class VendorRepository {
  Future<List<Vendor>> getVendors() async {
    try {
      final response = await http.get(Uri.parse('https://deligo.vtlabs.dev/api/vendors/list?lat=28.7040592&long=77.10249019999999&meta%5Bvendor_type%5D=food&page=1&per_page=15'));
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List vendors = decoded['data']; // Adjust if structure is different
        return vendors.map((e) => Vendor.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load vendors');
      }
    } catch (e) {
      throw Exception('Vendor Error: $e');
    }
  }
}