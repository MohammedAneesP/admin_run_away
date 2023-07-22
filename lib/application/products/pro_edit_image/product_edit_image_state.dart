part of 'product_edit_image_bloc.dart';

 class ProductEditImageState {
  List<dynamic> firImages;
final String anErrorMessage;
  ProductEditImageState({required this.firImages,required this.anErrorMessage});
}

class ProductEditImageInitial extends ProductEditImageState {
  ProductEditImageInitial():super(firImages: [],anErrorMessage: "");
}