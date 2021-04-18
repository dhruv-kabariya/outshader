import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'search_cubit/address_bloc/address_bloc.dart';

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
    print(_center);
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
    print(_center);
    address.add(NewLatlng(newLatLng: _center));
  }

  void _onMapCreated(GoogleMapController controller) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<AddressBloc, AddressState>(
        bloc: address,
        builder: (context, state) {
          if (state is AddressSelected) {
            return Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  // markers: marker,
                  onCameraMove: _onCameraMove,
                  initialCameraPosition:
                      CameraPosition(target: _center, zoom: 18),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Icon(Icons.location_on),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20, bottom: 20),
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          address.add(ChangeAddress(
                              address:
                                  (address.state as AddressSelected).address));
                        },
                        child: Card(
                          elevation: 5,
                          child: Icon(Icons.edit),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Card(
                          elevation: 5,
                          child: Icon(Icons.save),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
