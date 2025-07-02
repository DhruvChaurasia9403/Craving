import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product_model.dart';
import '../../repositories/product_repository.dart';

class ProductCubit extends Cubit<List<ProductModel>> {
  final ProductRepository _repository;

  ProductCubit({ProductRepository? repository})
      : _repository = repository ?? ProductRepository(),
        super([]);

  Future<void> fetchProducts(String vendorId) async {
    try {
      final products = await _repository.getProductsByVendor(vendorId);
      emit(products);
    } catch (e) {
      emit([]);
    }
  }
}
