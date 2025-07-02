import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/category_model.dart';
import '../../repositories/category_repository.dart';

class CategoryCubit extends Cubit<List<CategoryModel>> {
  final CategoryRepository _repository;

  CategoryCubit({CategoryRepository? repository})
      : _repository = repository ?? CategoryRepository(),
        super([]);

  Future<void> fetchCategories() async {
    try {
      final categories = await _repository.getCategories();
      emit(categories);
    } catch (e) {
      emit([]);
    }
  }
}
