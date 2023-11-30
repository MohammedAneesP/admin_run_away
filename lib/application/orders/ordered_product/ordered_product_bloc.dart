import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'ordered_product_event.dart';
part 'ordered_product_state.dart';

class OrderedProductBloc
    extends Bloc<OrderedProductEvent, OrderedProductState> {
  OrderedProductBloc() : super(OrderedProductInitial()) {
    on<AnSingleOrder>((event, emit) async {
      try {
        final anData = await FirebaseFirestore.instance
            .collection("products")
            .doc(event.anProductId)
            .get();
        final anProduct = anData.data();
        if (anProduct!.isEmpty) {
          return emit(OrderedProductState(
              anProduct: {},
              anErrorMessage: "Something went Wrong",
              anOrder: {}));
        } else {
          final anValue = await FirebaseFirestore.instance
              .collection("orders")
              .doc(event.anOrderDocId)
              .get();
          final anOrder = anValue.data();
          if (anOrder!.isEmpty) {
            return emit(OrderedProductState(
                anProduct: {},
                anErrorMessage: "Something went Wrong",
                anOrder: {}));
          } else {
            return emit(OrderedProductState(
                anProduct: anProduct,
                anErrorMessage: "Alright",
                anOrder: anOrder));
          }
        }
      } catch (e) {
        log(e.toString());
      }
    });
    on<ResetOrder>((event, emit) {
      return emit(OrderedProductState(
          anProduct: {}, anErrorMessage: "Nothing", anOrder: {}));
    });
  }
}
