import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:malu/models/models.dart';
import 'package:malu/utils/services/firebase_firestore_service.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/food_repository.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc({required this.repository}) : super(const ExploreState()) {
    on<DataRequested>(_onDataRequested);
  }

  final FirebaseFirestoreService dbService = FirebaseFirestoreService();
  final FoodRepository repository;

  void _onDataRequested(DataRequested event, Emitter<ExploreState> emit) async {
    emit(state.copyWith(status: ExploreStatus.loading));
    try {
      final foodList = await repository.getFoods();
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
