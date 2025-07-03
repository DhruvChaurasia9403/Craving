import 'package:craving/repositories/vendor_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'vendor_state.dart';

class VendorCubit extends Cubit<VendorState> {
  final VendorRepository _repository;

  VendorCubit(this._repository) : super(VendorInitial());

  Future<void> fetchVendors() async {
    emit(VendorLoading());
    try { //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403
      final vendors = await _repository.getVendors();
      emit(VendorLoaded(vendors));
    } catch (e) {
      emit(VendorError(e.toString()));
    }
  }
} //By Dhruv Chaurasia github : https://github.com/DhruvChaurasia9403