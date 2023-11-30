import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'product_orderd_an_user_event.dart';
part 'product_orderd_an_user_state.dart';

class ProductOrderdAnUserBloc
    extends Bloc<ProductOrderdAnUserEvent, ProductOrderdAnUserState> {
  ProductOrderdAnUserBloc() : super(ProductOrderdAnUserInitial()) {
    on<OrdersByAnUser>((event, emit) async {
      try {
        final anValues = await FirebaseFirestore.instance
            .collection("orders")
            .doc(event.anDocmentId)
            .get();
        if (anValues.exists) {
          final allOrders = anValues.data();

          if (allOrders!.isEmpty) {
            return emit(ProductOrderdAnUserState(
                thisUsersProducts: {},
                anErrorMessage: "Something went wrong",
                products: []));
          } else {
            List<dynamic> theIds = [];
            Map<String, dynamic> theProd = {};
            theProd = allOrders["products"];
            theProd.forEach((key, value) {
              theIds.add(key);
            });
            final products =
                await FirebaseFirestore.instance.collection("products").get();
            final allProducts = products.docs;
            if (allProducts.isEmpty) {
              return emit(ProductOrderdAnUserState(
                  thisUsersProducts: {},
                  anErrorMessage: "Something went wrong",
                  products: []));
            } else {
              final theProducts = allProducts.where((element) {
                return theIds.contains(element.id);
              }).toList();
              return emit(ProductOrderdAnUserState(
                  thisUsersProducts: allOrders,
                  anErrorMessage: '',
                  products: theProducts));
            }
          }
        } else {
          return emit(ProductOrderdAnUserState(
              thisUsersProducts: {},
              anErrorMessage: "Something went wrong",
              products: []));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
