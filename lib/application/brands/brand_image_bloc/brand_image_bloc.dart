import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'brand_image_event.dart';
part 'brand_image_state.dart';

class BrandImageBloc extends Bloc<BrandImageEvent, BrandImageState> {
  BrandImageBloc() : super(BrandImageInitial()) {
    on<AddingImage>((event, emit) async {
      XFile? fromGallery =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      return emit(BrandImageState(anImage: fromGallery));
    });
    on<RemoveImage>((event, emit)async {
      return emit(BrandImageState(anImage: null));
    } );
  }
}
