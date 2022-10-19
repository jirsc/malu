import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// To generate the meal.g.dart file run:
// 'flutter pub run build_runner build'
//  in the project root.
part 'meal.g.dart';

/// {@template product}
/// Meal model
///
/// [Meal.empty] represents an empty product.
/// {@endtemplate}
///
@JsonSerializable()
class Meal extends Equatable {
  /// {@macro product}
  const Meal({
    this.foodId = '',
    this.foodName = '',
    this.foodImageUrl = '',
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return _$MealFromJson(json);
  }

  factory Meal.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    return Meal.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => _$MealToJson(this);

  final String foodId;
  final String foodName;
  final String foodImageUrl;

  /// Empty product
  static const empty = Meal(foodId: '');

  /// Convenience getter to determine whether the current product is empty.
  bool get isEmpty => this == Meal.empty;

  /// Convenience getter to determine whether the current product is not empty.
  bool get hasData => this != Meal.empty;

  @override
  List<Object?> get props => [
        foodId,
        foodName,
        foodImageUrl,
      ];
}
