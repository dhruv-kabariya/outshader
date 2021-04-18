import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outshade/address_bloc/address_bloc.dart';

class MapRender extends StatefulWidget {
  MapRender({Key key}) : super(key: key);

  @override
  _MapRenderState createState() => _MapRenderState();
}

class _MapRenderState extends State<MapRender> {
  LatLng _center;
  AddressBloc address;
  Set<Marker> marker;

  @override
  void initState() {
    address = BlocProvider.of<AddressBloc>(context);
    _center = (address.state as AddressSelected).address.latLng;
    marker = {
      Marker(
        markerId: MarkerId("marker"),
        position: _center,
        icon: BitmapDescriptor.defaultMarker,
      )
    };
    super.initState();
  }

  void _onCameraMove(CameraPosition position) {
    _center = position.target;
    marker = {
      Marker(
        markerId: MarkerId("marker"),
        position: position.target,
        icon: BitmapDescriptor.defaultMarker,
      )
    };

    address.add(NewLatlng(newLatLng: position.target));
  }

  void _onMapCreated(GoogleMapController controller) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<AddressBloc, AddressState>(
        bloc: address,
        builder: (context, state) {
          if (state is AddressSelected) {
            return GoogleMap(
              onMapCreated: _onMapCreated,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              markers: marker,
              onCameraMove: _onCameraMove,
              initialCameraPosition: CameraPosition(target: _center, zoom: 11),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
