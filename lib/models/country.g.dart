// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      code: json['code'] as String,
      flag_1x1: json['flag_1x1'] as String? ?? '',
      flag_4x3: json['flag_4x3'] as String? ?? '',
      name: json['name'] as String? ?? '',
      iso: json['iso'] as bool? ?? true,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'code': instance.code,
      'flag_1x1': instance.flag_1x1,
      'flag_4x3': instance.flag_4x3,
      'name': instance.name,
      'iso': instance.iso,
    };
