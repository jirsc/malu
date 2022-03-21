// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specification_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecificationOption _$SpecificationOptionFromJson(Map<String, dynamic> json) =>
    SpecificationOption(
      name: json['name'] as String,
      additionalPrice: (json['additionalPrice'] as num).toDouble(),
      available: json['available'] as bool? ?? true,
      selected: json['selected'] as bool? ?? false,
    );

Map<String, dynamic> _$SpecificationOptionToJson(
        SpecificationOption instance) =>
    <String, dynamic>{
      'name': instance.name,
      'additionalPrice': instance.additionalPrice,
      'available': instance.available,
      'selected': instance.selected,
    };
