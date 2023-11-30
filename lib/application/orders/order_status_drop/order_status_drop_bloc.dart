import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:run_away_admin/presentation/orders/ordered_products/an_product_details.dart';

part 'order_status_drop_event.dart';
part 'order_status_drop_state.dart';

class OrderStatusDropBloc
    extends Bloc<OrderStatusDropEvent, OrderStatusDropState> {
  OrderStatusDropBloc() : super(OrderStatusDropInitial()) {
    
    on<StatusChanging>((event, emit) {
      selectedStatus = event.anStatus;
      return emit(
          OrderStatusDropState(anErrorMessage: "", anStatus: selectedStatus,));
    });
  }
}
