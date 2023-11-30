part of 'ordered_product_bloc.dart';

@immutable
sealed class OrderedProductEvent {}

class AnSingleOrder extends OrderedProductEvent {
  final String anProductId;
  final String anOrderDocId;
  AnSingleOrder({required this.anOrderDocId, required this.anProductId});
}

class ResetOrder extends OrderedProductEvent{}
