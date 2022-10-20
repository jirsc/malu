import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:malu/models/models.dart';
// import 'package:malu/repositories/repositories.dart';
import 'package:malu/utils/services/firebase_firestore_service.dart';
import 'package:equatable/equatable.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(const ExploreState()) {
    on<DataRequested>(_onDataRequested);
  }

  // final VendorRepository repository;
  final FirebaseFirestoreService dbService = FirebaseFirestoreService();

  void _onDataRequested(DataRequested event, Emitter<ExploreState> emit) async {
    emit(state.copyWith(status: ExploreStatus.loading));
    try {
      // final vendors = await repository.getVendors();
      final foodList = await dbService.getListOfFoods();
      final user = await dbService.getUser(event.user);
      emit(
        state.copyWith(
          status: ExploreStatus.loaded,
          foods: foodList,
          user: user,
        ),
      );
    } catch (error, stacktrace) {
      //print(stacktrace);
      emit(state.copyWith(status: ExploreStatus.error));
    }
  }
}
