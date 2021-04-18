import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outshade/firebase_image/image_handle/imagehandle_bloc.dart';
import 'package:outshade/firebase_image/show_thumbnail.dart';

class FireBaseImageWidget extends StatefulWidget {
  FireBaseImageWidget({
    Key key,
  }) : super(key: key);

  @override
  _FireBaseImageWidgetState createState() => _FireBaseImageWidgetState();
}

class _FireBaseImageWidgetState extends State<FireBaseImageWidget> {
  final picker = ImagePicker();
  ImagehandleBloc bloc;

  void pickimage(BuildContext context) async {
    final pickImage = await picker.getImage(source: ImageSource.gallery);
    bloc.add(UploadImage(image: File(pickImage.path)));
  }

  @override
  void initState() {
    bloc = BlocProvider.of<ImagehandleBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: bloc,
      listener: (context, state) {
        if (state is UploadingImage) {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Uploading Image")
                      ],
                    ),
                  ),
                );
              });
        }
        if (state is UploadedImage) {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        child: Column(children: [
          TextButton(
            onPressed: () {
              pickimage(context);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text("Upload Image"),
            ),
          ),
          TextButton(
            onPressed: () {
              bloc.add(GetImages());
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShowThumbNail(
                        bloc: bloc,
                      )));
            },
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text("Show Thumbnail"),
            ),
          ),
        ]),
      ),
    );
  }
}
