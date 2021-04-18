part of 'imagehandle_bloc.dart';

abstract class ImagehandleState extends Equatable {
  const ImagehandleState();

  @override
  List<Object> get props => [];
}

class ImagehandleInitial extends ImagehandleState {}

class UploadingImage extends ImagehandleState {}

class UploadedImage extends ImagehandleState {}

class GettingImages extends ImagehandleState {}

class ImageList extends ImagehandleState {
  final List<Thumbnail> images;

  ImageList(this.images);
  @override
  List<Object> get props => [images];
}
