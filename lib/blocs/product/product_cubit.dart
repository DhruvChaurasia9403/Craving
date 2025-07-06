import 'package:craving/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../models/product_model.dart';
// import '../repositories/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit(this.repository) : super(ProductInitial());

  void fetchProducts(int vendorId, List<int> categoryIds) async {
    emit(ProductLoading());
    try {
      final products = await repository.fetchProducts(vendorId, categoryIds);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
