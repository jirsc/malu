import 'package:bloc/bloc.dart';
import 'package:doeat/models/models.dart';
import 'package:doeat/repositories/repositories.dart';
import 'package:doeat/utils/services/services.dart';
import 'package:equatable/equatable.dart';
import 'package:authentication_repository/authentication_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({required this.repository}) : super(const OrderState()) {
    on<DataRequested>(_onDataRequested);
  }

  final VendorRepository repository;
  final FirebaseFirestoreService dbService = FirebaseFirestoreService();

  void _onDataRequested(DataRequested event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      final vendors = await repository.getVendors();
      final user = await dbService.getUser(event.user);
      emit(
        state.copyWith(
          status: OrderStatus.dataLoaded,
          vendors: vendors,
          user: user,
        ),
      );
    } catch (error, stacktrace) {
      //print(stacktrace);
      emit(state.copyWith(status: OrderStatus.error));
    }
  }
}
