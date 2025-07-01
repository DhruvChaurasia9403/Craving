import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../model/product_model.dart';

class ProductController extends GetxController {
  var products = <ProductModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadAllProducts();
  }

  Future<void> loadAllProducts() async {
    try {
      isLoading(true);

      // Load all 3 product files
      final files = [
        'assets/products1.json',
        'assets/products2.json',
        'assets/products3.json'
      ];

      List<ProductModel> allProducts = [];

      for (String path in files) {
        final String response = await rootBundle.loadString(path);
        final List<dynamic> data = json.decode(response);
        allProducts.addAll(data.map((item) => ProductModel.fromJson(item)));
      }

      products.value = allProducts;
    } catch (e) {
      print('Error loading products: $e');
    } finally {
      isLoading(false);
    }
  }
}
