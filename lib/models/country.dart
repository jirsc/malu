import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'country.g.dart';

/// {@template country}
/// Country model
///
/// [Country.empty] represents an empty country.
/// {@endtemplate}
///
@JsonSerializable()
class Country extends Equatable {
  /// {@macro country}
  final String code;
  final String flag_1x1;
  final String flag_4x3;
  final String name;
  final bool iso;

  const Country({
    required this.code,
    this.flag_1x1 = '',
    this.flag_4x3 = '',
    this.name = '',
    this.iso = true,
  });

  /// Empty country
  static const empty = Country(code: '');

  /// Convenience getter to determine whether the current country is empty.
  bool get isEmpty => this == Country.empty;

  /// Convenience getter to determine whether the current country is not empty.
  bool get hasData => this != Country.empty;

  factory Country.fromJson(Map<String, dynamic> json) {
    return _$CountryFromJson(json);
  }

  factory Country.fromDynamicJson(Map<dynamic, dynamic> json) => Country(
        code: json['code'] as String,
        flag_1x1: json['flag_1x1'] as String? ?? '',
        flag_4x3: json['flag_4x3'] as String? ?? '',
        name: json['name'] as String? ?? '',
        iso: json['iso'] as bool? ?? true,
      );

  Map<String, dynamic> toJson() => _$CountryToJson(this);

  factory Country.fromFirestore(DocumentSnapshot snapshot) {
    return Country.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  @override
  List<Object?> get props => [
        code,
        flag_1x1,
        flag_4x3,
        name,
        iso,
      ];
}
