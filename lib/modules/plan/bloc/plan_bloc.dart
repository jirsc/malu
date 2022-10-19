import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:malu/models/food.dart';

import '../../../utils/services/firebase_firestore_service.dart';

part 'plan_event.dart';
part 'plan_state.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc() : super(const PlanState()) {
    on<SelectedDateChanged>(_onSelectedDateChanged);
    on<MealPlanUpdated>(_onMealPlanUpdated);
  }

  final FirebaseFirestoreService dbService = FirebaseFirestoreService();

  void _onSelectedDateChanged(
      SelectedDateChanged event, Emitter<PlanState> emit) async {
    emit(state.copyWith(status: PlanStatus.loading));
    try {
      final user = await dbService.getUser(event.user);
      final mealPlanList = await dbService.getListOfMealPlan(event.user.id);
      final foodList = mealPlanList.isNotEmpty
          ? await _getFoodListFromMealPlan(event.date, mealPlanList)
          : event.foodList;
      emit(
        state.copyWith(
          status: PlanStatus.selectedDateChanged,
          user: user,
          date: event.date,
          foodList: foodList,
        ),
      );
    } catch (error, stacktrace) {
      print(stacktrace);
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

  Future<List<Food>> _getFoodListFromMealPlan(
      String date, List<MealPlan> list) async {
    final mealPlan = list.where((item) => item.date == date);
    if (mealPlan.isEmpty) {
      return Food.generateRandomListWhere(count: 4);
    } else {
      final breakfast =
          await dbService.getFood(mealPlan.first.breakfast.foodId);
      final lunch = await dbService.getFood(mealPlan.first.lunch.foodId);
      final dinner = await dbService.getFood(mealPlan.first.dinner.foodId);
      return [breakfast, lunch, dinner];
    }
  }
}
