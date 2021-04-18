import 'package:google_maps_flutter/google_maps_flutter.dart';

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class Place {
  String streetNumber;
  String street;
  String city;
  String zipCode;

  LatLng latLng;
  Suggestion suggestion;

  Place(
      {this.streetNumber,
      this.street,
      this.city,
      this.zipCode,
      this.latLng,
      this.suggestion});

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
  }
}
