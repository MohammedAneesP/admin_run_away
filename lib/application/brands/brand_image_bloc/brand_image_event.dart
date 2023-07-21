part of 'brand_image_bloc.dart';

@immutable
abstract class BrandImageEvent {}

class AddingImage extends BrandImageEvent{} 

class RemoveImage extends BrandImageEvent{}