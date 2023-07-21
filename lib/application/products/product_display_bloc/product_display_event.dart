part of 'product_display_bloc.dart';

@immutable
abstract class ProductDisplayEvent {}

class ProductsDisplaying extends ProductDisplayEvent {}

class ProductDeleting extends ProductDisplayEvent {
  final String anProductId;
  ProductDeleting({required this.anProductId});
}
