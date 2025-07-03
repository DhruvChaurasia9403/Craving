import '../../models/product_model.dart';

class CartState {
  final List<Product> items;
  final double total;

  CartState({required this.items, required this.total});

  CartState copyWith({List<Product>? items, double? total}) {
    return CartState(
      items: items ?? this.items,
      total: total ?? this.total,
    );
  }
}