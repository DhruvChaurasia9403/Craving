import 'package:craving/pages/product/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/vendor_model.dart';
import '../../controller/product_controller.dart';
import '../../model/product_model.dart';

class VendorDetailView extends StatelessWidget {
  final VendorModel vendor;

  const VendorDetailView({super.key, required this.vendor});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();

    // Filter products by vendor
    List<ProductModel> vendorProducts = productController.products
        .where((product) => product.vendorId == vendor.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(vendor.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                vendor.image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Text(vendor.address, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.timer, size: 16),
                const SizedBox(width: 4),
                Text(vendor.time),
                const SizedBox(width: 12),
                const Icon(Icons.star, size: 16, color: Colors.orange),
                const SizedBox(width: 4),
                Text("${vendor.rating}"),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Products", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: vendorProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final product = vendorProducts[index];
                return InkWell(
                  onTap: () {
                    Get.to(() => ProductDetailView(product: product));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.image,
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text("₹${product.price.toStringAsFixed(2)}", style: const TextStyle(color: Colors.green)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
