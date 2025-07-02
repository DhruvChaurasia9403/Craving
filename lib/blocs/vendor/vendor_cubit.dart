import 'package:craving/repositories/vendory_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/vendor_model.dart';
// import '../../repositories/vendor_repository.dart';

class VendorCubit extends Cubit<List<VendorModel>> {
  final VendorRepository _repository;

  VendorCubit({VendorRepository? repository})
      : _repository = repository ?? VendorRepository(),
        super([]);

  Future<void> fetchVendors() async {
    try {
      final vendors = await _repository.getVendors();
      emit(vendors);
    } catch (e) {
      emit([]);
    }
  }
}
