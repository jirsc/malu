// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealPlan _$MealPlanFromJson(Map<String, dynamic> json) => MealPlan(
      date: json['date'] as String? ?? '',
      breakfast: json['breakfast'] == null
          ? Meal.empty
          : Meal.fromJson(json['breakfast'] as Map<String, dynamic>),
      lunch: json['lunch'] == null
          ? Meal.empty
          : Meal.fromJson(json['lunch'] as Map<String, dynamic>),
      dinner: json['dinner'] == null
          ? Meal.empty
          : Meal.fromJson(json['dinner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MealPlanToJson(MealPlan instance) => <String, dynamic>{
      'date': instance.date,
      'breakfast': instance.breakfast,
      'lunch': instance.lunch,
      'dinner': instance.dinner,
    };
