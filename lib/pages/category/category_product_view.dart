import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/category_model.dart';
import '../../controller/product_controller.dart';
import '../../model/product_model.dart';
import '../product/product_detail_view.dart';

class CategoryProductView extends StatelessWidget {
  final CategoryModel category;

  const CategoryProductView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();

    // Filter products that match the category
    List<ProductModel> filteredProducts = productController.products
        .where((product) => product.categoryId == category.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: filteredProducts.isEmpty
            ? const Center(child: Text("No products in this category."))
            : GridView.builder(
          itemCount: filteredProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final product = filteredProducts[index];
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
      ),
    );
  }
}
