part of 'drop_brand_bloc.dart';

class DropBrandState {
  String anBrandName;
  DropBrandState({required this.anBrandName});
}

class DropBrandInitial extends DropBrandState {
  DropBrandInitial():super(anBrandName: "");
}
