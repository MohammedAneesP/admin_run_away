part of 'product_edit_image_bloc.dart';

@immutable
abstract class ProductEditImageEvent {}

class RemoveAllImages extends ProductEditImageEvent{}

class ProductNetImagesDisply extends ProductEditImageEvent {

  final String anId;
  ProductNetImagesDisply({ required this.anId});
}

class ProductImageEditAdd extends ProductEditImageEvent {
  final String anId;
  ProductImageEditAdd({required this.anId});
}

class ProductRemoveImage extends ProductEditImageEvent{
  final String anId;
  final int index;
  ProductRemoveImage({required this.index,required this.anId});
}
