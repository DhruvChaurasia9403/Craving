import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../model/vendor_model.dart';

class VendorController extends GetxController {
  var vendors = <VendorModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadVendors();
  }

  Future<void> loadVendors() async {
    try {
      isLoading(true);
      final String response = await rootBundle.loadString('assets/vendors.json');
      final data = json.decode(response);
      vendors.value = List<VendorModel>.from(
        data.map((item) => VendorModel.fromJson(item)),
      );
    } catch (e) {
      print('Error loading vendors: $e');
    } finally {
      isLoading(false);
    }
  }
}
