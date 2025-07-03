import 'package:equatable/equatable.dart';
import '../../models/category_model.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;

  CategoryLoaded(this.categories); //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
  //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
  @override
  List<Object?> get props => [categories];
}
//By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message); //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403

  @override
  List<Object?> get props => [message];
}
