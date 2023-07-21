part of 'brand_displaying_bloc.dart';

@immutable
abstract class BrandDisplayingEvent {}

class BrandDetaiLing extends BrandDisplayingEvent {}

class BrandDeleting extends BrandDisplayingEvent {
 final String anBrandId;
  BrandDeleting({required this.anBrandId});
}
