import 'package:doeat/models/models.dart';
import 'package:doeat/models/specification_option.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'specification.g.dart';

/// {@template specification}
/// Specification model
///
/// [Specification.empty] represents an empty specification.
/// {@endtemplate}
///
@JsonSerializable()
class Specification extends Equatable {
  /// {@macro specification}
  final String name;
  final String selectionType;
  final bool required;
  final int min;
  final int max;
  final String description;
  final List<SpecificationOption> option;

  const Specification({
    required this.name,
    required this.selectionType,
    required this.required,
    this.min = 0,
    this.max = 0,
    this.description = '',
    required this.option,
  });

  /// Empty specification
  static const empty = Specification(
    name: '',
    selectionType: '',
    required: false,
    option: [SpecificationOption.empty],
  );

  /// Convenience getter to determine whether the current specification is empty.
  bool get isEmpty => this == Specification.empty;

  /// Convenience getter to determine whether the current specification is not empty.
  bool get hasData => this != Specification.empty;

  factory Specification.fromJson(Map<String, dynamic> json) {
    return _$SpecificationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SpecificationToJson(this);

  factory Specification.fromFirestore(DocumentSnapshot snapshot) {
    return Specification.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  @override
  List<Object?> get props => [
        name,
        selectionType,
        required,
        min,
        max,
        description,
        option,
      ];

  static List<Specification> generateMilkTeaSpecifications() {
    return [
      Specification(
        name: 'Size',
        selectionType: 'single',
        required: true,
        description: 'Pick 1',
        option: SpecificationOption.generateSizeOptions(),
      ),
      Specification(
        name: 'Sugar Level',
        selectionType: 'single',
        required: true,
        description: 'Pick 1',
        option: SpecificationOption.generateSugarLevelOptions(),
      ),
      Specification(
        name: 'Ice Options',
        selectionType: 'single',
        required: true,
        description: 'Pick 1',
        option: SpecificationOption.generateIceOptions(),
      ),
      Specification(
        name: 'Add ons',
        selectionType: 'multiple',
        required: false,
        description: 'Optional',
        option: SpecificationOption.generateAddOn1Options(),
      ),
    ];
  }
}
