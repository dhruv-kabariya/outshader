import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outshade/search_cubit/search_cubit.dart';
import 'package:outshade/search_location.dart';

import 'address_bloc/address_bloc.dart';
import 'map/address_widget.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Outshader"),
        centerTitle: true,
      ),
      body: BlocBuilder<AddressBloc, AddressState>(
        bloc: BlocProvider.of<AddressBloc>(context),
        builder: (context, state) {
          if (state is NoAddressSelected || state is AddressChange) {
            return SearchLocation();
          }
          if (state is AddressSelected) {
            return MapRender();
          }
          return Container();
        },
      ),
    );
  }
}
