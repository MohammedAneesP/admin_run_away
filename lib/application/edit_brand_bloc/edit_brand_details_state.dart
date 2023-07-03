part of 'edit_brand_details_bloc.dart';

class EditBrandDetailsState {
  final Map<String, dynamic> anBrandMap;
  final String theError;

  EditBrandDetailsState({required this.anBrandMap,required this.theError});
}

class EditBrandDetailsInitial extends EditBrandDetailsState {
  EditBrandDetailsInitial() : super(anBrandMap: {},theError: "");
}

