import 'package:bloc/bloc.dart';
import 'package:malu/models/models.dart';
import 'package:malu/modules/modules.dart';
import 'package:malu/repositories/repositories.dart';
import 'package:malu/utils/services/services.dart';
import 'package:equatable/equatable.dart';
import 'package:authentication_repository/authentication_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const OrderState()) {
    //on<DataRequested>(_onDataRequested);
    on<OrderAdded>(_onOrderAdded);
  }

  /* final VendorRepository repository;
  final FirebaseFirestoreService dbService = FirebaseFirestoreService(); */

  /* void _onDataRequested(DataRequested event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      /* final vendors = await repository.getVendors();
      final user = await dbService.getUser(event.user); */
      emit(
        state.copyWith(
          status: OrderStatus.dataLoaded,
        ),
      );
    } catch (error, stacktrace) {
      //print(stacktrace);
      emit(state.copyWith(status: OrderStatus.error));
    }
  } */

  void _onOrderAdded(OrderAdded event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      emit(
        state.copyWith(
          status: OrderStatus.basketUpdated,
          basket: event.basket,
        ),
      );
    } catch (error, stacktrace) {
      //print(stacktrace);
      emit(state.copyWith(status: OrderStatus.error));
    }
  }
}
