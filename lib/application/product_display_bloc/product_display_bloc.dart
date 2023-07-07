import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'product_display_event.dart';
part 'product_display_state.dart';

class ProductDisplayBloc
    extends Bloc<ProductDisplayEvent, ProductDisplayState> {
  ProductDisplayBloc() : super(ProductDisplayInitial()) {
    on<ProductsDisplaying>((event, emit) async {
      final anResp =
          await FirebaseFirestore.instance.collection("products").get();
      final respData = anResp.docs;
      if (respData.isEmpty) {
        return emit(
          ProductDisplayState(
            proFireResponse: [],
            errorMessage: "An error Occured",
          ),
        );
      } else {
        return emit(ProductDisplayState(
            proFireResponse: respData, errorMessage: "errorMessage"));
      }
    });
  }
}
