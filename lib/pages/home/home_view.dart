import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/category_controller.dart';
import '../../controller/product_controller.dart';
import '../../controller/vendor_controller.dart';
import '../../pages/category/category_product_view.dart';
import '../../pages/vendor/vendor_detail_view.dart';
import '../../pages/product/product_detail_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final vendorController = Get.put(VendorController());
    final productController = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Craving"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Categories", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Obx(() {
                if (categoryController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryController.categories.length,
                    itemBuilder: (context, index) {
                      final category = categoryController.categories[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => CategoryProductView(category: category));
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(category.image),
                              ),
                              const SizedBox(height: 6),
                              Text(category.name),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
              const SizedBox(height: 20),

              const Text("Vendors", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Obx(() {
                if (vendorController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: vendorController.vendors.length,
                    itemBuilder: (context, index) {
                      final vendor = vendorController.vendors[index];
                      return InkWell(
                        onTap: () {
                          Get.to(() => VendorDetailView(vendor: vendor));
                        },
                        child: Container(
                          width: 200,
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  vendor.image,
                                  height: 80,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(vendor.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text(vendor.address, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
              const SizedBox(height: 20),

              const Text("Products", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Obx(() {
                if (productController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: productController.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final product = productController.products[index];
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
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
