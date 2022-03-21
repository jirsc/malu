import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'specification_option.g.dart';

/// {@template specification option}
/// SpecificationOption model
///
/// [SpecificationOption.empty] represents an empty specification option.
/// {@endtemplate}
///
@JsonSerializable()
class SpecificationOption extends Equatable {
  /// {@macro specification option}
  final String name;
  final double additionalPrice;
  final bool available;
  final bool selected;

  const SpecificationOption({
    required this.name,
    required this.additionalPrice,
    this.available = true,
    this.selected = false,
  });

  /// Empty specification option
  static const empty = SpecificationOption(name: '', additionalPrice: 0.00);

  /// Convenience getter to determine whether the current specification option is empty.
  bool get isEmpty => this == SpecificationOption.empty;

  /// Convenience getter to determine whether the current specification option is not empty.
  bool get hasData => this != SpecificationOption.empty;

  factory SpecificationOption.fromJson(Map<String, dynamic> json) {
    return _$SpecificationOptionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SpecificationOptionToJson(this);

  factory SpecificationOption.fromFirestore(DocumentSnapshot snapshot) {
    return SpecificationOption.fromJson(
        snapshot.data() as Map<String, dynamic>);
  }

  @override
  List<Object?> get props => [
        name,
        additionalPrice,
        available,
        selected,
      ];

  static List<SpecificationOption> generateSizeOptions() {
    return [
      const SpecificationOption(
        name: 'Regular',
        additionalPrice: 0.00,
        available: true,
        selected: false,
      ),
      const SpecificationOption(
        name: 'Large',
        additionalPrice: 10.00,
        available: true,
        selected: false,
      ),
    ];
  }

  static List<SpecificationOption> generateSugarLevelOptions() {
    return [
      const SpecificationOption(
        name: '1.2 (120% sugar)',
        additionalPrice: 0.00,
        available: true,
        selected: false,
      ),
      const SpecificationOption(
        name: '1 (100% sugar)',
        additionalPrice: 0.00,
        available: true,
        selected: false,
      ),
      const SpecificationOption(
        name: '0.7 (70% sugar)',
        additionalPrice: 0.00,
        available: true,
        selected: false,
      ),
      const SpecificationOption(
        name: '0.5 (50% sugar)',
        additionalPrice: 0.00,
        available: true,
        selected: false,
      ),
      const SpecificationOption(
        name: '0.3 (30% sugar)',
        additionalPrice: 0.00,
        available: true,
        selected: false,
      ),
      const SpecificationOption(
        name: '0 (no sugar)',
        additionalPrice: 0.00,
        available: true,
        selected: false,
      ),
    ];
  }

  static List<SpecificationOption> generateIceOptions() {
    return [
      const SpecificationOption(
        name: 'Normal ice',
        additionalPrice: 0.00,
        available: true,
        selected: false,
      ),
      const SpecificationOption(
        name: 'Less ice',
        additionalPrice: 0.00,
        available: true,
        selected: false,
      ),
      const SpecificationOption(
        name: 'More ice',
        additionalPrice: 0.00,
        available: true,
        selected: false,
      ),
      const SpecificationOption(
        name: 'Cold but no ice',
        additionalPrice: 0.00,
        available: true,
        selected: false,
      ),
    ];
  }

  static List<SpecificationOption> generateAddOn1Options() {
    return [
      const SpecificationOption(
        name: 'Pearl',
        additionalPrice: 10.00,
        available: true,
        selected: false,
      ),
      const SpecificationOption(
        name: 'Coconut Jelly',
        additionalPrice: 10.00,
        available: true,
        selected: false,
      ),
      const SpecificationOption(
        name: 'Grass Jelly',
        additionalPrice: 20.00,
        available: false,
        selected: false,
      ),
      const SpecificationOption(
        name: 'Pudding',
        additionalPrice: 20.00,
        available: true,
        selected: false,
      ),
      const SpecificationOption(
        name: 'Salty Cream',
        additionalPrice: 20.00,
        available: true,
        selected: false,
      ),
    ];
  }

  static List<SpecificationOption> generateAddOn2Options() {
    return [
      const SpecificationOption(
        name: 'Regular',
        additionalPrice: 0.00,
        available: true,
        selected: false,
      ),
      const SpecificationOption(
        name: 'Large',
        additionalPrice: 10.00,
        available: true,
        selected: false,
      ),
    ];
  }
}
