import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'order_viewing_event.dart';
part 'order_viewing_state.dart';

class OrderViewingBloc extends Bloc<OrderViewingEvent, OrderViewingState> {
  OrderViewingBloc() : super(OrderViewingInitial()) {
    on<OrderViewing>((event, emit) async {
      final anData =
          await FirebaseFirestore.instance.collection("orders").get();
      final allOrders = anData.docs;
      if (allOrders.isEmpty) {
        return emit(OrderViewingState(errorMessage: "", orders: []));
      } else {
        Map<String, dynamic> anMap = {};

        for (var element in allOrders) {
          anMap.addAll(element.data());
        }

        final anReversed = allOrders.reversed.toList();

        return emit(OrderViewingState(
          errorMessage: "",
          orders: anReversed,
        ));
      }
    });
  }
}
