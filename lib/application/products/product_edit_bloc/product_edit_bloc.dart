import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'product_edit_event.dart';
part 'product_edit_state.dart';

class ProductEditBloc extends Bloc<ProductEditEvent, ProductEditState> {
  ProductEditBloc() : super(ProductEditInitial()) {
    on<EditProductData>((event, emit) async {
      final productDocsnap = await FirebaseFirestore.instance
          .collection("products")
          .doc(event.anId)
          .get();

      final productData = productDocsnap.data();
      if (productData!.isEmpty) {
        return emit(
            ProductEditState(anData: {}, errorMessage: "An error Occured"));
      } else {
        return emit(ProductEditState(anData: productData, errorMessage: ""));
      }
    });
  }
}
