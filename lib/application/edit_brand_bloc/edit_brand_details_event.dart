part of 'edit_brand_details_bloc.dart';

@immutable
abstract class EditBrandDetailsEvent {}

class EditBrandData extends EditBrandDetailsEvent {
  final String anId;
  EditBrandData({required this.anId});
}

//class ErrorOccured extends EditBrandDetailsEvent {}
