import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:outshade/model/thumbnail.dart';
import 'package:outshade/services/image_service.dart';

part 'imagehandle_event.dart';
part 'imagehandle_state.dart';

class ImagehandleBloc extends Bloc<ImagehandleEvent, ImagehandleState> {
  ImagehandleBloc() : super(ImagehandleInitial());

  ImageService service = ImageService();

  @override
  Stream<ImagehandleState> mapEventToState(
    ImagehandleEvent event,
  ) async* {
    if (event is UploadImage) {
      yield UploadingImage();
      await service.uploadImages(event.image);
      yield UploadedImage();
      yield ImagehandleInitial();
    }

    if (event is GetImages) {
      yield GettingImages();
      yield ImageList(await service.getThumbnails());
    }
  }
}
