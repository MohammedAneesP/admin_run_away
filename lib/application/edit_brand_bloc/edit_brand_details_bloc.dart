import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'edit_brand_details_event.dart';
part 'edit_brand_details_state.dart';

class EditBrandDetailsBloc
    extends Bloc<EditBrandDetailsEvent, EditBrandDetailsState> {
  EditBrandDetailsBloc() : super(EditBrandDetailsInitial()) {
    on<EditBrandData>((event, emit) async {
      final brandDocSnap = await FirebaseFirestore.instance
          .collection("brands")
          .doc(event.anId)
          .get();

      final brandData = brandDocSnap.data();
      if (brandData == null) {
        return emit(EditBrandDetailsState(
            anBrandMap: {}, theError: "an error occured "));
      } else {
        return emit(EditBrandDetailsState(anBrandMap: brandData, theError: ""));
      }
    });
    // on<ErrorOccured>((event, emit) async {
    //   return emit(EditBrandDetailsState(
    //       anBrandMap: {}, theError: "an network error occured"));
    // });
  }
}
