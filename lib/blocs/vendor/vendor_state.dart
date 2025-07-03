import 'package:equatable/equatable.dart';
import '../../models/vendor_model.dart';

abstract class VendorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VendorInitial extends VendorState {}

class VendorLoading extends VendorState {}

class VendorLoaded extends VendorState {
  final List<Vendor> vendors;

  VendorLoaded(this.vendors);

  @override
  List<Object?> get props => [vendors];
}

class VendorError extends VendorState {
  final String message;

  VendorError(this.message);

  @override
  List<Object?> get props => [message];
}
