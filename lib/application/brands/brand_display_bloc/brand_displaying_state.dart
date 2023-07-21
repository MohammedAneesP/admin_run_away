part of 'brand_displaying_bloc.dart';

class BrandDisplayingState {
  final brandFireResp;
  final String errorMessage;
  BrandDisplayingState({
    required this.brandFireResp,
    required this.errorMessage,
  });
}

class BrandDisplayingInitial extends BrandDisplayingState {
  BrandDisplayingInitial() : super(brandFireResp: [], errorMessage: "");
}
