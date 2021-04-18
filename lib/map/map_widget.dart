import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'address_widget.dart';
import 'search_cubit/address_bloc/address_bloc.dart';
import 'search_location.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
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
    );
  }
}
