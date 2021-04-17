import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outshade/search_cubit/search_cubit.dart';
import 'package:outshade/search_location.dart';

import 'address_bloc/address_bloc.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  SearchCubit search = SearchCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Outshader"),
        centerTitle: true,
      ),
      body: BlocBuilder<AddressBloc, AddressState>(
        builder: (context, state) {
          if (state is NoAddressSelected) {
            return SearchLocation(
                searchController: searchController, search: search);
          }
          if (state is AddressSelected) {
            return Container(
              child: Text(
                  state.address.latLng.toString() + " " + state.address.street),
            );
          }
          return Container();
        },
      ),
    );
  }
}
