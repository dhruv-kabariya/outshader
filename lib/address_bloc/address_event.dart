part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class SelectAddress extends AddressEvent {
  final Suggestion address;

  SelectAddress({this.address});

  @override
  List<Object> get props => [address];
}

class NewLatlng extends AddressEvent {
  final LatLng newLatLng;

  NewLatlng({this.newLatLng});

  @override
  List<Object> get props => [newLatLng];
}
