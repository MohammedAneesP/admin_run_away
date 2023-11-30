part of 'order_status_drop_bloc.dart';

@immutable
sealed class OrderStatusDropEvent {}



class StatusChanging extends OrderStatusDropEvent {
  final String anStatus;
  StatusChanging({required this.anStatus});
}
