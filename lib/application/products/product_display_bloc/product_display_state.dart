part of 'product_display_bloc.dart';

class ProductDisplayState {
  final proFireResponse;
  final String errorMessage;
  ProductDisplayState(
      {required this.proFireResponse, required this.errorMessage,});
}

class ProductDisplayInitial extends ProductDisplayState {
  ProductDisplayInitial() : super(proFireResponse: [],errorMessage: '');
}
