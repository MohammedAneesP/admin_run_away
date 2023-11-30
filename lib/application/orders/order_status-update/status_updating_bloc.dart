import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'status_updating_event.dart';
part 'status_updating_state.dart';

class StatusUpdatingBloc
    extends Bloc<StatusUpdatingEvent, StatusUpdatingState> {
  StatusUpdatingBloc() : super(StatusUpdatingInitial()) {
    on<UpdatingStatus>((event, emit) async {
      try {
        final anValue = await FirebaseFirestore.instance
            .collection("orders")
            .doc(event.anOrderId)
            .get();
        if (anValue.exists) {
          final anData = anValue.data();
          if (anData!.isEmpty) {
            return emit(StatusUpdatingState(
                anErrorMessage: "", anOrderId: "", anProductId: ""));
          } else {
            anData["products"][event.anProductid]["status"] = event.anStatus;
            await FirebaseFirestore.instance
                .collection("orders")
                .doc(event.anOrderId)
                .update(anData);
            return emit(StatusUpdatingState(
                anErrorMessage: "",
                anOrderId: event.anOrderId,
                anProductId: event.anProductid));
          }
        } else {
          return emit(StatusUpdatingState(
              anErrorMessage: "", anOrderId: "", anProductId: ""));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
