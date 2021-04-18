import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outshade/firebase_image/image_handle/imagehandle_bloc.dart';

class ShowThumbNail extends StatelessWidget {
  const ShowThumbNail({Key key, this.bloc}) : super(key: key);

  final ImagehandleBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thumbnails"),
        centerTitle: true,
      ),
      body: BlocBuilder<ImagehandleBloc, ImagehandleState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is GettingImages) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
          if (state is ImageList) {
            return ListView.builder(
                itemCount: state.images.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          // height: 50,
                          // width: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          padding: EdgeInsets.all(5),
                          child: Image.network(state.images[index].small),
                        ),
                        Container(
                          // height: 100,
                          // width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          padding: EdgeInsets.all(8),
                          child: Image.network(state.images[index].large),
                        )
                      ],
                    ),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
