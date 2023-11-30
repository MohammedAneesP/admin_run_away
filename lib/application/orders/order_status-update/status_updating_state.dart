part of 'status_updating_bloc.dart';

class StatusUpdatingState {
  final String anErrorMessage;
  final String anOrderId;
  final String anProductId;
  StatusUpdatingState(
      {required this.anErrorMessage,
      required this.anOrderId,
      required this.anProductId});
}

 class StatusUpdatingInitial extends StatusUpdatingState {
  StatusUpdatingInitial()
      : super(anErrorMessage: "", anOrderId: "", anProductId: "");
}
