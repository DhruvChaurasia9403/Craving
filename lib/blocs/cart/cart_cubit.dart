
import 'package:craving/blocs/cart/cart_state.dart';
import 'package:craving/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final Map<String, int> _quantities = {};
  final Map<String, Product> _products = {};

  CartCubit() : super(CartState(items: [], total: 0.0));

  void addToCart(Product product) {
    _quantities[product.id] = (_quantities[product.id] ?? 0) + 1;
    _products[product.id] = product;
    _emitCartState(); //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
  }

  void removeFromCart(Product product) {
    if (_quantities.containsKey(product.id) && _quantities[product.id]! > 0) {
      _quantities[product.id] = _quantities[product.id]! - 1;
      if (_quantities[product.id] == 0) {
        _quantities.remove(product.id);
        _products.remove(product.id);
      }
      _emitCartState();
    }
  }

  int getQuantity(Product product) => _quantities[product.id] ?? 0;

  void _emitCartState() {
    final items = <Product>[];
    double total = 0.0; //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
    _quantities.forEach((id, qty) {
      final product = _products[id];
      if (product != null) {
        for (int i = 0; i < qty; i++) {
          items.add(product);
          total += product.price;
        }
      }
    }); //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
    emit(CartState(items: items, total: total));
  }
}