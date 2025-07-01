import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../model/category_model.dart';

class CategoryController extends GetxController {
  var categories = <CategoryModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      isLoading(true);
      final String response = await rootBundle.loadString('assets/categories.json');
      final data = json.decode(response);
      categories.value = List<CategoryModel>.from(
        data.map((item) => CategoryModel.fromJson(item)),
      );
    } catch (e) {
      print('Error loading categories: $e');
    } finally {
      isLoading(false);
    }
  }
}
