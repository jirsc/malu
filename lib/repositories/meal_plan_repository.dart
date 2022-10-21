import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:malu/utils/services/firebase_firestore_service.dart';

class MealPlanRepository {
  MealPlanRepository({
    required this.service,
  });

  final FirebaseFirestoreService service;
  List<MealPlan> mealPlanList = [];

  Future<List<MealPlan>> getMealPlans(String userId) async {
    mealPlanList = await service.getListOfMealPlan(userId);
    return mealPlanList;
  }
}
