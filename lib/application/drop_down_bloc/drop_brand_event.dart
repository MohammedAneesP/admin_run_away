part of 'drop_brand_bloc.dart';

@immutable
abstract class DropBrandEvent {}

class AnBrandSelect extends DropBrandEvent{
  String theBrandString;
  AnBrandSelect({required this.theBrandString});
}