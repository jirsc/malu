import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:malu/models/food.dart';
import 'package:malu/repositories/food_repository.dart';

import '../../../repositories/meal_plan_repository.dart';
import '../../../utils/services/firebase_firestore_service.dart';

part 'plan_event.dart';
part 'plan_state.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc() : super(const PlanState()) {
    on<SelectedDateChanged>(_onSelectedDateChanged);
    on<MealPlanUpdated>(_onMealPlanUpdated);
  }

  final FoodRepository foodRepository =
      FoodRepository(service: FirebaseFirestoreService());
  final MealPlanRepository mealPlanRepository =
      MealPlanRepository(service: FirebaseFirestoreService());
  final FirebaseFirestoreService dbService = FirebaseFirestoreService();

  void _onSelectedDateChanged(
      SelectedDateChanged event, Emitter<PlanState> emit) async {
    emit(state.copyWith(status: PlanStatus.loading));
    try {
      final user = await dbService.getUser(event.user);

      if (event.foodList.isEmpty) {
        final mealPlanList = mealPlanRepository.mealPlanList.isEmpty
            ? await dbService.getListOfMealPlan(event.user.id)
            : mealPlanRepository.mealPlanList;
        final foodsFromFirestore = foodRepository.foodList.isEmpty
            ? await dbService.getListOfFoods()
            : foodRepository.foodList;
        final foodList = mealPlanList.isNotEmpty
            ? await _getFoodListFromMealPlan(
                date: event.date,
                mealPlanList: mealPlanList,
                foodList: foodsFromFirestore,
              )
            : _getRandomFoodList(foodsFromFirestore);
        emit(
          state.copyWith(
            status: PlanStatus.selectedDateChanged,
            user: user,
            date: event.date,
            foodList: foodList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: PlanStatus.selectedDateChanged,
            user: user,
            date: event.date,
            foodList: event.foodList,
          ),
        );
      }
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(status: PlanStatus.error));
    }
  }

  void _onMealPlanUpdated(
      MealPlanUpdated event, Emitter<PlanState> emit) async {
    emit(state.copyWith(status: PlanStatus.loading));
    try {
      final breakfast = Meal(
          foodId: event.foodList[0].id,
          foodName: event.foodList[0].name,
          foodImageUrl: event.foodList[0].imageUrl);
      final lunch = Meal(
          foodId: event.foodList[1].id,
          foodName: event.foodList[1].name,
          foodImageUrl: event.foodList[1].imageUrl);
      final dinner = Meal(
          foodId: event.foodList[2].id,
          foodName: event.foodList[2].name,
          foodImageUrl: event.foodList[2].imageUrl);
      final mealPlan = MealPlan(
          date: event.date, breakfast: breakfast, lunch: lunch, dinner: dinner);
      await dbService.insertMealPlan(event.user, mealPlan);
      emit(
        state.copyWith(
          status: PlanStatus.mealPlanUpdated,
          date: event.date,
          foodList: event.foodList,
        ),
      );
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(status: PlanStatus.error));
    }
  }

  Future<List<Food>> _getFoodListFromMealPlan({
    required String date,
    required List<MealPlan> mealPlanList,
    required List<Food> foodList,
  }) async {
    final mealPlan = mealPlanList.where((item) => item.date == date);
    if (mealPlan.isEmpty) {
      return Food.randomizeList(foodList);
    } else {
      final breakfast =
          await dbService.getFood(mealPlan.first.breakfast.foodId);
      final lunch = await dbService.getFood(mealPlan.first.lunch.foodId);
      final dinner = await dbService.getFood(mealPlan.first.dinner.foodId);
      return [breakfast, lunch, dinner];
    }
  }

  List<Food> _getRandomFoodList(List<Food>? foodList) {
    if (foodList == null || foodList.isEmpty) {
      return Food.generateRecommendedFood();
    } else {
      return Food.randomizeList(foodList);
    }
  }
}
