part of 'product_edit_bloc.dart';

@immutable
abstract class ProductEditEvent {}

class EditProductData extends ProductEditEvent{
  final String anId;
  EditProductData({required this.anId});
}
