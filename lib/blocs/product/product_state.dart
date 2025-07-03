import 'package:equatable/equatable.dart';
import '../../models/product_model.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}
//By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);

  @override //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
