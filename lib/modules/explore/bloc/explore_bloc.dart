import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:doeat/models/models.dart';
import 'package:doeat/repositories/repositories.dart';
import 'package:doeat/utils/services/firebase_firestore_service.dart';
import 'package:equatable/equatable.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc({required this.repository}) : super(const ExploreState()) {
    on<DataRequested>(_onDataRequested);
  }

  final VendorRepository repository;
  final FirebaseFirestoreService dbService = FirebaseFirestoreService();

  void _onDataRequested(DataRequested event, Emitter<ExploreState> emit) async {
    emit(state.copyWith(status: ExploreStatus.loading));
    try {
      final vendors = await repository.getVendors();
      final user = await dbService.getUser(event.user);
      emit(
        state.copyWith(
          status: ExploreStatus.loaded,
          vendors: vendors,
          user: user,
        ),
      );
    } catch (error, stacktrace) {
      //print(stacktrace);
      emit(state.copyWith(status: ExploreStatus.error));
    }
  }
}
