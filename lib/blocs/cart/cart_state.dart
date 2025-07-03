import '../../models/product_model.dart';

class CartState {
  final List<Product> items;
  final double total;

  CartState({required this.items, required this.total});

  CartState copyWith({List<Product>? items, double? total}) {
    return CartState( //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
      items: items ?? this.items,
      total: total ?? this.total,
    );
  }
} //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403