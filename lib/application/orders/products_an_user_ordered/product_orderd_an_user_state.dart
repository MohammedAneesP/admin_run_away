part of 'product_orderd_an_user_bloc.dart';

class ProductOrderdAnUserState {
  final Map<String,dynamic> thisUsersProducts;
  final List<dynamic> products;
  final String anErrorMessage;
  ProductOrderdAnUserState(
      {required this.thisUsersProducts, required this.anErrorMessage,required this.products});
}

final class ProductOrderdAnUserInitial extends ProductOrderdAnUserState {
  ProductOrderdAnUserInitial()
      : super(anErrorMessage: '', thisUsersProducts: {},products: []);
}
