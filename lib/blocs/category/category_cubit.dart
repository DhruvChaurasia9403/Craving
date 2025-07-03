import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_state.dart';
import '../../repositories/category_repository.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository _repository;

  CategoryCubit(this._repository) : super(CategoryInitial());

  Future<void> fetchCategories() async {
    emit(CategoryLoading()); //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
    try {
      final categories = await _repository.getCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    } //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
  }
}