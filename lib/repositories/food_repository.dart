import 'dart:async';
import 'package:malu/utils/services/firebase_firestore_service.dart';
import 'package:malu/models/food.dart';

class FoodRepository {
  FoodRepository({
    required this.service,
  });

  final FirebaseFirestoreService service;
  List<Food> foodList = [];

  Future<List<Food>> getFoods() async {
    foodList = await service.getListOfFoods();
    return foodList;
  }
}
