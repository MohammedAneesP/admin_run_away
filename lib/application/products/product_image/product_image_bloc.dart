import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'product_image_event.dart';
part 'product_image_state.dart';

List<XFile> theImageList = [];

class ProductImageBloc extends Bloc<ProductImageEvent, ProductImageState> {
  ProductImageBloc() : super(ProductImageInitial()) {
    on<ProductImageEvent>((event, emit) async {
      final oneImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (oneImage != null) {
        theImageList.add(oneImage);
      }
      if (theImageList.isNotEmpty) {
        return emit(ProductImageState(imageList: theImageList));
      }
    });
    on<RemoveProductImage>((event, emit) {
      theImageList.clear();
      return emit(ProductImageState(imageList: []));
    });
  }
}
