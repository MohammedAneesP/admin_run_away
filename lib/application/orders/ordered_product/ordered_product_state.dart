part of 'ordered_product_bloc.dart';

class OrderedProductState {
  final Map<String, dynamic> anProduct;
  final Map<String, dynamic> anOrder;
  final String anErrorMessage;
  OrderedProductState(
      {required this.anProduct,
      required this.anErrorMessage,
      required this.anOrder});
}

class OrderedProductInitial extends OrderedProductState {
  OrderedProductInitial()
      : super(anErrorMessage: "", anProduct: {}, anOrder: {});
}
