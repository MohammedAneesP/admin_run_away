part of 'order_status_drop_bloc.dart';

class OrderStatusDropState {
  final String anStatus;
  final String anErrorMessage;
  OrderStatusDropState({required this.anErrorMessage, required this.anStatus});
}

final class OrderStatusDropInitial extends OrderStatusDropState {
  OrderStatusDropInitial() : super(anErrorMessage: '', anStatus: "");
}
