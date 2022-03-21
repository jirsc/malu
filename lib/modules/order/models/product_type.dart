import 'package:doeat/modules/modules.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'product_type.g.dart';

/// {@template product type}
/// ProductType model
///
/// [ProductType.empty] represents an empty product type.
/// {@endtemplate}
///
@JsonSerializable()
class ProductType extends Equatable {
  /// {@macro product type}
  final String id;
  final String name;
  final String code;
  final List<Specification> specification;

  const ProductType({
    required this.id,
    required this.name,
    required this.code,
    required this.specification,
  });

  /// Empty product type
  static const empty = ProductType(
    id: '',
    name: '',
    code: '',
    specification: [],
  );

  /// Convenience getter to determine whether the current product type is empty.
  bool get isEmpty => this == ProductType.empty;

  /// Convenience getter to determine whether the current product type is not empty.
  bool get hasData => this != ProductType.empty;

  factory ProductType.fromJson(Map<String, dynamic> json) {
    return _$ProductTypeFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductTypeToJson(this);

  factory ProductType.fromFirestore(DocumentSnapshot snapshot) {
    return ProductType.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        code,
        specification,
      ];

  static List<ProductType> generateProductTypes() {
    return [
      ProductType(
        id: '1',
        name: 'Milk Tea Specifications',
        code: 'MCDO',
        specification: Specification.generateMilkTeaSpecifications(),
      ),
    ];
  }
}
