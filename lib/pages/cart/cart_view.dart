import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../product/product_detail_view.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const Center(child: Text("Your cart is empty."));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartController.cartItems[index];

                  return ListTile(
                    leading: Image.network(item.product.image, width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(item.product.name),
                    subtitle: Text("₹${item.product.price.toStringAsFixed(2)} x ${item.quantity}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => cartController.decreaseQuantity(item.product),
                          icon: const Icon(Icons.remove),
                        ),
                        Text(item.quantity.toString()),
                        IconButton(
                          onPressed: () => cartController.increaseQuantity(item.product),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    onLongPress: () => cartController.removeFromCart(item.product),
                    onTap: () => Get.to(() => ProductDetailView(product: item.product)),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total: ₹${cartController.totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () {
                      // Placeholder for checkout
                      Get.snackbar("Order", "Order placed successfully!", snackPosition: SnackPosition.BOTTOM);
                      cartController.clearCart();
                    },
                    child: const Text("Checkout"),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
