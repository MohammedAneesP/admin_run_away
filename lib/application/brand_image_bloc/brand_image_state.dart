part of 'brand_image_bloc.dart';

 class BrandImageState {
  XFile? anImage;
  BrandImageState({required this.anImage});
 }

class BrandImageInitial extends BrandImageState {
BrandImageInitial():super(anImage: null);
}
