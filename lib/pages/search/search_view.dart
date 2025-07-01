import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/product_controller.dart';
import '../../model/product_model.dart';
import '../product/product_detail_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController searchController = TextEditingController();
  final ProductController productController = Get.find<ProductController>();
  List<ProductModel> searchResults = [];

  void _search(String query) {
    final allProducts = productController.products;
    final filtered = allProducts
        .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      searchResults = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Products"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: _search,
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: searchResults.isEmpty
                  ? const Center(child: Text("No results found."))
                  : GridView.builder(
                itemCount: searchResults.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = searchResults[index];
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
          ],
        ),
      ),
    );
  }
}
