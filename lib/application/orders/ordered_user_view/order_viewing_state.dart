part of 'order_viewing_bloc.dart';

class OrderViewingState {
  final List<dynamic>orders;
  final String errorMessage;

  OrderViewingState({
    required this.errorMessage,
    required this.orders,
  });
}

final class OrderViewingInitial extends OrderViewingState {
  OrderViewingInitial() : super( errorMessage: "",orders: []);
}
