import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:malu/models/food.dart';

part 'plan_event.dart';
part 'plan_state.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc() : super(const PlanState()) {
    on<SelectedDateChanged>(_onSelectedDateChanged);
    on<MealPlanUpdated>(_onMealPlanUpdated);
  }

  void _onSelectedDateChanged(
      SelectedDateChanged event, Emitter<PlanState> emit) async {
    emit(state.copyWith(status: PlanStatus.loading));
    try {
      emit(
        state.copyWith(
          status: PlanStatus.selectedDateChanged,
          foodList: event.foodList,
        ),
      );
    } catch (error, stacktrace) {
      //print(stacktrace);
      emit(state.copyWith(status: PlanStatus.error));
    }
  }

  void _onMealPlanUpdated(
      MealPlanUpdated event, Emitter<PlanState> emit) async {
    emit(state.copyWith(status: PlanStatus.loading));
    try {
      emit(
        state.copyWith(
          status: PlanStatus.mealPlanUpdated,
          foodList: event.foodList,
        ),
      );
    } catch (error, stacktrace) {
      //print(stacktrace);
      emit(state.copyWith(status: PlanStatus.error));
    }
  }
}
