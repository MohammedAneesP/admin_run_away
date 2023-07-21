part of 'product_edit_bloc.dart';

class ProductEditState {
  final Map<String,dynamic> anData;
  final String errorMessage;
  ProductEditState({required this.anData,required this.errorMessage});
}

class ProductEditInitial extends ProductEditState {
  ProductEditInitial():super(anData: {},errorMessage: "");
}
