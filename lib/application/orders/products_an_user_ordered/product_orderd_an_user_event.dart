part of 'product_orderd_an_user_bloc.dart';

@immutable
sealed class ProductOrderdAnUserEvent {}

class OrdersByAnUser extends ProductOrderdAnUserEvent{
  final String anDocmentId;
  OrdersByAnUser({required this.anDocmentId});
}
