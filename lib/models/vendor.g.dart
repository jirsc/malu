// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vendor _$VendorFromJson(Map<String, dynamic> json) => Vendor(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String? ?? '',
      name: json['name'] as String? ?? '',
      distance: json['distance'] as String? ?? '',
      score: json['score'] as num? ?? 0,
      ratingCount: json['ratingCount'] as num? ?? 0,
      weeklyOrderCount: json['weeklyOrderCount'] as num? ?? 0,
      category: (json['category'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [''],
      location: json['location'] as Map<String, dynamic>? ?? const {},
      description: json['description'] as String? ?? '',
      productList: (json['productList'] as List<dynamic>?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [Product(id: '', name: '', price: 0)],
    );

Map<String, dynamic> _$VendorToJson(Vendor instance) => <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'distance': instance.distance,
      'score': instance.score,
      'ratingCount': instance.ratingCount,
      'weeklyOrderCount': instance.weeklyOrderCount,
      'category': instance.category,
      'location': instance.location,
      'description': instance.description,
      'productList': instance.productList,
    };
