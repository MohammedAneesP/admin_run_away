import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:run_away_admin/presentation/product_page/add_edit_pro/product_adding.dart';

part 'drop_brand_event.dart';
part 'drop_brand_state.dart';


 
class DropBrandBloc extends Bloc<DropBrandEvent, DropBrandState> {
  DropBrandBloc() : super(DropBrandInitial()) {
    on<DropBrandEvent>((event, emit) {
      return emit(DropBrandState(anBrandName: anSelected.toString()));
    });
  }
}
