import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'brand_displaying_event.dart';
part 'brand_displaying_state.dart';

class BrandDisplayingBloc
    extends Bloc<BrandDisplayingEvent, BrandDisplayingState> {
  BrandDisplayingBloc() : super(BrandDisplayingInitial()) {
    on<BrandDetaiLing>((event, emit) async {
      final brandData =
          await FirebaseFirestore.instance.collection("brands").get();
      final brandResp = brandData.docs;
      if (brandResp.isEmpty) {
        return emit(
            BrandDisplayingState(brandFireResp: [], errorMessage: "No data"));
      } else {
        return emit(
            BrandDisplayingState(brandFireResp: brandResp, errorMessage: ""));
      }
    });
    on<BrandDeleting>((event, emit) async {
      final brandCollection = FirebaseFirestore.instance.collection("brands");

      final productCollection =
          await FirebaseFirestore.instance.collection("products").get();

      final theValues = productCollection.docs;

      if (theValues.isNotEmpty) {
        for (var product in theValues) {
          if (product.data()["brandId"] == event.anBrandId) {
            final proCollection =
                FirebaseFirestore.instance.collection("products");
            await proCollection.doc(product.data()["productId"]).delete();
          }
        }
      }
      log(brandCollection.doc(event.anBrandId).toString());
      brandCollection.doc(event.anBrandId).delete();
      final brandsData = await brandCollection.get();
      final brands = brandsData.docs;
      return emit(
          BrandDisplayingState(brandFireResp: brands, errorMessage: ""));
    });
  }
}
