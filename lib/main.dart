import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_image/image_handle/imagehandle_bloc.dart';
import 'home.dart';
import 'map/search_cubit/address_bloc/address_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MapApp());
}

class MapApp extends StatelessWidget {
  const MapApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (create) => AddressBloc(),
          ),
          BlocProvider(create: (create) => ImagehandleBloc())
        ],
        child: Home(),
      ),
    );
  }
}
