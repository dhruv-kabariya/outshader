part of 'imagehandle_bloc.dart';

abstract class ImagehandleEvent extends Equatable {
  const ImagehandleEvent();

  @override
  List<Object> get props => [];
}

class UploadImage extends ImagehandleEvent {
  final File image;

  UploadImage({this.image});
  @override
  List<Object> get props => [image];
}

class GetImages extends ImagehandleEvent {}
