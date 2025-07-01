import 'package:get/get.dart';
import '../model/product_model.dart';
import '../model/cart_item_model.dart';

class CartController extends GetxController {
  var cartItems = <CartItemModel>[].obs;

  void addToCart(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(CartItemModel(product: product, quantity: 1));
    }
  }

  void increaseQuantity(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) cartItems[index].quantity++;
  }

  void decreaseQuantity(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1 && cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    } else {
      removeFromCart(product);
    }
  }

  void removeFromCart(ProductModel product) {
    cartItems.removeWhere((item) => item.product.id == product.id);
  }

  double get totalPrice => cartItems.fold(0,
          (sum, item) => sum + (item.product.price * item.quantity));

  void clearCart() {
    cartItems.clear();
  }
}
