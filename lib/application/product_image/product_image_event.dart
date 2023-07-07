part of 'product_image_bloc.dart';

@immutable
abstract class ProductImageEvent {}

class ProductImageAdding extends ProductImageEvent {}

class RemoveProductImage extends ProductImageEvent {}

