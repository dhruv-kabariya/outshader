part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class NoAddressSelected extends AddressState {}

class AddressSelected extends AddressState {
  final Place address;

  AddressSelected({this.address});

  @override
  List<Object> get props => [address];
}

class ChangeAddress extends AddressState {}
