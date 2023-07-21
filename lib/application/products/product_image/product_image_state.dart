part of 'product_image_bloc.dart';

 class ProductImageState {
   List<XFile>? imageList;
  ProductImageState({required this.imageList});
}

class ProductImageInitial extends ProductImageState {
  ProductImageInitial():super(imageList: []);
}
