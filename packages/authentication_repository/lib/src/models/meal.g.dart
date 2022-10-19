// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
      foodId: json['foodId'] as String? ?? '',
      foodName: json['foodName'] as String? ?? '',
      foodImageUrl: json['foodImageUrl'] as String? ?? '',
    );

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
      'foodId': instance.foodId,
      'foodName': instance.foodName,
      'foodImageUrl': instance.foodImageUrl,
    };
