import 'package:doeat/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'vendor.g.dart';

/// {@template user}
/// Vendor model
///
/// [Vendor.empty] represents an empty vendor.
/// {@endtemplate}
///
@JsonSerializable()
class Vendor extends Equatable {
  /// {@macro vendor}
  final String id;
  final String imageUrl;
  final String name;
  final String distance;
  final num score;
  final num ratingCount;
  final num weeklyOrderCount;
  final List<String> category;
  final Map<String, dynamic> location;
  final String description;
  final List<Product> productList;

  const Vendor({
    required this.id,
    this.imageUrl = '',
    this.name = '',
    this.distance = '',
    this.score = 0,
    this.ratingCount = 0,
    this.weeklyOrderCount = 0,
    this.category = const [''],
    this.location = const {},
    this.description = '',
    this.productList = const [Product(id: '', name: '', price: 0)],
  });

  /// Empty vendor
  static const empty = Vendor(id: '');

  /// Convenience getter to determine whether the current vendor is empty.
  bool get isEmpty => this == Vendor.empty;

  /// Convenience getter to determine whether the current vendor is not empty.
  bool get hasData => this != Vendor.empty;

  /* Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'distance': distance,
      'score': score,
      'ratingCount': ratingCount,
      'weeklyOrderCount': weeklyOrderCount,
      'category': category,
      'location': location,
      'description': description,
    };
  }

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      distance: json['distance'] as String,
      score: json['score'] as num,
      ratingCount: json['ratingCount'] as num,
      weeklyOrderCount: json['weeklyOrderCount'] as num,
      category: json['category'] as List<String>,
      location: json['location'] as Map<String, dynamic>,
      description: json['description'] as String,
    );
  } */

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return _$VendorFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VendorToJson(this);

  factory Vendor.fromFirestore(DocumentSnapshot snapshot) {
    return Vendor.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        name,
        distance,
        score,
        ratingCount,
        weeklyOrderCount,
        category,
        description,
        productList,
      ];

  static List<Vendor> generateRecommendedVendor() {
    return [
      const Vendor(
          imageUrl: 'assets/images/mcdo.jpg',
          name: 'McDonald\'s',
          distance: 'MCDO',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '1'),
      const Vendor(
          imageUrl: 'assets/images/coco.jpeg',
          name: 'Coco Fresh',
          distance: 'COCO FRESH',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '2'),
      const Vendor(
          imageUrl: 'assets/images/mary_grace.jpg',
          name: 'Mary Grace',
          distance: 'MARY GRACE',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '3'),
      const Vendor(
          imageUrl: 'assets/images/chatime.jpeg',
          name: 'Chatime',
          distance: 'CHATIME',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '4'),
      const Vendor(
          imageUrl: 'assets/images/food3.jpg',
          name: 'Conti\'s',
          distance: 'CONTI\'S',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '5'),
      const Vendor(
          imageUrl: 'assets/images/food2.jpg',
          name: 'Cabalen',
          distance: 'CABALEN',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '6'),
    ];
  }

  static List<Vendor> generateTrendingVendor() {
    return [
      const Vendor(
          imageUrl: 'assets/images/mcdo1.jpg',
          name: 'McDonald\'s',
          distance: 'MCDO',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '1'),
      const Vendor(
          imageUrl: 'assets/images/coco.png',
          name: 'Coco Fresh',
          distance: 'COCO FRESH',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '2'),
      const Vendor(
          imageUrl: 'assets/images/mary_grace3.jpg',
          name: 'Mary Grace',
          distance: 'MARY GRACE',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '3'),
      const Vendor(
          imageUrl: 'assets/images/chatime1.jpg',
          name: 'Chatime',
          distance: 'CHATIME',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '4'),
      const Vendor(
          imageUrl: 'assets/images/food1.jpg',
          name: 'Conti\'s',
          distance: 'CONTI\'S',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '5'),
      const Vendor(
          imageUrl: 'assets/images/food4.jpg',
          name: 'Cabalen',
          distance: 'CABALEN',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '6'),
    ];
  }

  static List<Vendor> generateVendorList() {
    return [
      const Vendor(
          imageUrl: 'assets/images/food1.jpg',
          name: 'McDonald\'s',
          distance: 'MCDO',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: ''),
      const Vendor(
          imageUrl: 'assets/images/food4.jpg',
          name: 'McDonald\'s',
          distance: 'MCDO',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: ''),
      const Vendor(
          imageUrl: 'assets/images/food3.jpg',
          name: 'McDonald\'s',
          distance: 'MCDO',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: ''),
      const Vendor(
          imageUrl: 'assets/images/food2.jpg',
          name: 'McDonald\'s',
          distance: 'MCDO',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: ''),
    ];
  }
}
