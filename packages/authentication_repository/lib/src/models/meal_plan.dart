import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'meal.dart';

// To generate the food.g.dart file run:
// 'flutter pub run build_runner build'
//  in the project root.
part 'meal_plan.g.dart';

// enum EntryType { login, signUp }

// extension EntryTypeX on EntryType {
//   bool get isLogin => this == EntryType.login;
//   bool get isSignUp => this == EntryType.signUp;
// }

/// {@template product}
/// MealPlan model
///
/// [MealPlan.empty] represents an empty product.
/// {@endtemplate}
///
@JsonSerializable()
class MealPlan extends Equatable {
  /// {@macro product}
  const MealPlan({
    this.date = '',
    this.breakfast = Meal.empty,
    this.lunch = Meal.empty,
    this.dinner = Meal.empty,
  });

  factory MealPlan.fromJson(Map<String, dynamic> json) {
    return _$MealPlanFromJson(json);
  }

  factory MealPlan.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    return MealPlan.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => _$MealPlanToJson(this);

  final String date;
  final Meal breakfast;
  final Meal lunch;
  final Meal dinner;

  /// Empty product
  static const empty = MealPlan(date: '');

  /// Convenience getter to determine whether the current product is empty.
  bool get isEmpty => this == MealPlan.empty;

  /// Convenience getter to determine whether the current product is not empty.
  bool get hasData => this != MealPlan.empty;

  @override
  List<Object?> get props => [
        date,
        breakfast,
        lunch,
        dinner,
      ];

  static List<MealPlan> generateRandomListWhere({required int count}) {
    // Convert List to Set to remove duplicates
    // Convert back to list then shuffle items
    // Get number of items based on variable 'count'
    return (generateDummyMealPlan().toSet().toList()..shuffle())
        .take(count)
        .toList();
  }

  static List<MealPlan> generateDummyMealPlan() {
    return [
      const MealPlan(
        date: '20221017',
        breakfast: Meal(
          foodId: "itlog",
          foodName: "01b",
          foodImageUrl: "/path/",
        ),
        lunch: Meal(
          foodId: "itlog",
          foodName: "01b",
          foodImageUrl: "/path/",
        ),
        dinner: Meal(
          foodId: "itlog",
          foodName: "01b",
          foodImageUrl: "/path/",
        ),
      ),
    ];
  }
}
