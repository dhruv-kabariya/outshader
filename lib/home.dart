import 'package:flutter/material.dart';

import 'firebase_image/firebase_image_widget.dart';
import 'map/map_widget.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Outshader"),
          bottom: TabBar(tabs: [
            Tab(child: Icon(Icons.map)),
            Tab(child: Icon(Icons.image)),
          ]),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [MapWidget(), FireBaseImageWidget()],
        ),
      ),
    );
  }
}
