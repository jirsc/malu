// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Specification _$SpecificationFromJson(Map<String, dynamic> json) =>
    Specification(
      name: json['name'] as String,
      selectionType: json['selectionType'] as String,
      required: json['required'] as bool,
      min: json['min'] as int? ?? 0,
      max: json['max'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      option: (json['option'] as List<dynamic>)
          .map((e) => SpecificationOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpecificationToJson(Specification instance) =>
    <String, dynamic>{
      'name': instance.name,
      'selectionType': instance.selectionType,
      'required': instance.required,
      'min': instance.min,
      'max': instance.max,
      'description': instance.description,
      'option': instance.option,
    };
