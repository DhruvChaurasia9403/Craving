
import 'package:craving/blocs/cart/cart_state.dart';
import 'package:craving/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final Map<String, int> _quantities = {};
  final Map<String, Product> _products = {};

  CartCubit() : super(CartState(items: [], total: 0.0));

  void addToCart(Product product) {
    final key = product.id.toString();
    _quantities[key] = (_quantities[key] ?? 0) + 1;
    _products[key] = product;
    _emitCartState();
  }

  void removeFromCart(Product product) {
    final key = product.id.toString();
    if (_quantities.containsKey(key) && _quantities[key]! > 0) {
      _quantities[key] = _quantities[key]! - 1;
      if (_quantities[key] == 0) {
        _quantities.remove(key);
        _products.remove(key);
      }
      _emitCartState();
    }
  }

  int getQuantity(Product product) => _quantities[product.id.toString()] ?? 0;

  void _emitCartState() {
    final items = <Product>[];
    double total = 0.0;
    _quantities.forEach((id, qty) {
      final product = _products[id];
      if (product != null) {
        for (int i = 0; i < qty; i++) {
          items.add(product);
          total += product.price;
        }
      }
    });
    emit(CartState(items: items, total: total));
  }
}