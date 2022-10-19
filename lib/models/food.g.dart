// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Food _$FoodFromJson(Map<String, dynamic> json) => Food(
      id: json['id'] as String? ?? '',
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String? ?? '',
      description: json['description'] as String? ?? '',
      specification: (json['specification'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          const [{}],
      category: (json['category'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [''],
      mealType: (json['mealType'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [''],
      score: (json['score'] as num?)?.toDouble() ?? 0,
      ratingCount: json['ratingCount'] as num? ?? 0,
      recommended: json['recommended'] as bool? ?? false,
    );

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'specification': instance.specification,
      'category': instance.category,
      'mealType': instance.mealType,
      'score': instance.score,
      'ratingCount': instance.ratingCount,
      'recommended': instance.recommended,
    };
