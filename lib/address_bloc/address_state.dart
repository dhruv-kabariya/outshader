part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class NoAddressSelected extends AddressState {}

class AddressChange extends AddressState {
  final Place address;

  AddressChange({this.address});

  @override
  List<Object> get props => [address];
}

class AddressSelected extends AddressState {
  final Place address;

  AddressSelected({this.address});

  @override
  List<Object> get props => [address];
}
