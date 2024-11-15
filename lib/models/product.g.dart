// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String? ?? '',
      productCount: json['productCount'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      specification: (json['specification'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          const [{}],
      category: (json['category'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [''],
      score: (json['score'] as num?)?.toDouble() ?? 0,
      ratingCount: json['ratingCount'] as num? ?? 0,
      recommended: json['recommended'] as bool? ?? false,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'productCount': instance.productCount,
      'description': instance.description,
      'specification': instance.specification,
      'category': instance.category,
      'score': instance.score,
      'ratingCount': instance.ratingCount,
      'recommended': instance.recommended,
    };
