import 'package:craving/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _repository;

  ProductCubit(this._repository) : super(ProductInitial());

  void fetchProducts(String vendorId) async {
    emit(ProductLoading()); //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
    try {
      final products = await _repository.getProducts(vendorId);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
//By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403