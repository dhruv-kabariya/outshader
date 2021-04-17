import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:outshade/search_cubit/search_cubit.dart';
import 'package:geocoder/geocoder.dart';

class AddressField extends StatelessWidget {
  AddressField({Key key}) : super(key: key);

  final TextEditingController home = TextEditingController();
  // final TextEditingController street = TextEditingController();

  String map_key = 'AIzaSyA0EH9lA1RVJWQYhY3EhpOW3uSEigUWn3s';
  final SearchCubit search = SearchCubit();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              var data = await PlacesAutocomplete.show(
                context: context,
                apiKey: map_key,
                mode: Mode.fullscreen,
                hint: "Search Address",
              );

              showPlaces(data.placeId);
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text("Search Address")),
          ),
        ],
      ),
    );
  }

  void showPlaces(String placeId) async {
    print(placeId);
  }
}
