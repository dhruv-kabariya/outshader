import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outshade/model/address.dart';
import 'package:outshade/search_service.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(NoAddressSelected());

  SearchService service = SearchService();

  @override
  Stream<AddressState> mapEventToState(
    AddressEvent event,
  ) async* {
    if (event is SelectAddress) {
      Place place = await service.getPlaceDetailFromId(event.address.placeId);

      yield AddressSelected(address: place);
    }
    if (event is NewLatlng) {
      Place place = (state as AddressSelected).address;
      place.latLng = event.newLatLng;
      yield AddressSelected(address: place);
    }
  }
}
