import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'product.g.dart';

/// {@template product}
/// Product model
///
/// [Product.empty] represents an empty product.
/// {@endtemplate}
///
@JsonSerializable()
class Product extends Equatable {
  /// {@macro product}
  final String id;
  final String imageUrl;
  final String name;
  final num price;
  final num score;
  final num ratingCount;
  final String description;
  final List<String> categoryCode;
  final bool isRecommended;

  const Product({
    required this.id,
    this.imageUrl = '',
    this.name = '',
    this.price = 0,
    this.score = 0,
    this.ratingCount = 0,
    this.description = '',
    this.categoryCode = const [''],
    this.isRecommended = false,
  });

  /// Empty product
  static const empty = Product(id: '');

  /// Convenience getter to determine whether the current product is empty.
  bool get isEmpty => this == Product.empty;

  /// Convenience getter to determine whether the current product is not empty.
  bool get hasData => this != Product.empty;

  /* Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'distance': distance,
      'score': score,
      'ratingCount': ratingCount,
      'price': price,
      'category': category,
      'location': location,
      'description': description,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      distance: json['distance'] as String,
      score: json['score'] as num,
      ratingCount: json['ratingCount'] as num,
      price: json['price'] as num,
      category: json['category'] as List<String>,
      location: json['location'] as Map<String, dynamic>,
      description: json['description'] as String,
    );
  } */

  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  factory Product.fromFirestore(DocumentSnapshot snapshot) {
    return Product.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        name,
        price,
        score,
        ratingCount,
        description,
        categoryCode,
        isRecommended,
      ];

  static List<Product> generateRecommendedProduct() {
    return [
      const Product(
          imageUrl: 'assets/images/food1.jpg',
          name: 'McDonald\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          categoryCode: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '1'),
      const Product(
          imageUrl: 'assets/images/food4.jpg',
          name: 'Coco Fresh',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          categoryCode: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '2'),
      const Product(
          imageUrl: 'assets/images/food3.jpg',
          name: 'Mary Grace',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          categoryCode: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '3'),
      const Product(
          imageUrl: 'assets/images/food2.jpg',
          name: 'Chatime',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          categoryCode: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '4'),
      const Product(
          imageUrl: 'assets/images/food1.jpg',
          name: 'Conti\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          categoryCode: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '5'),
      const Product(
          imageUrl: 'assets/images/food4.jpg',
          name: 'Cabalen',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          categoryCode: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '6'),
    ];
  }

  static List<Product> generateTrendingProduct() {
    return [
      const Product(
          imageUrl: 'assets/images/food1.jpg',
          name: 'McDonald\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          categoryCode: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '1'),
      const Product(
          imageUrl: 'assets/images/food4.jpg',
          name: 'Coco Fresh',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          categoryCode: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '2'),
      const Product(
          imageUrl: 'assets/images/food3.jpg',
          name: 'Mary Grace',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          categoryCode: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '3'),
      const Product(
          imageUrl: 'assets/images/food2.jpg',
          name: 'Chatime',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          categoryCode: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '4'),
      const Product(
          imageUrl: 'assets/images/food1.jpg',
          name: 'Conti\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          categoryCode: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '5'),
      const Product(
          imageUrl: 'assets/images/food4.jpg',
          name: 'Cabalen',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          categoryCode: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '6'),
    ];
  }

  static List<Product> generateProductList() {
    return [
      const Product(
          imageUrl: 'assets/images/food1.jpg',
          name: 'McDonald\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 90.00,
          categoryCode: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: ''),
      const Product(
          imageUrl: 'assets/images/food4.jpg',
          name: 'McDonald\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 85.00,
          categoryCode: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: ''),
      const Product(
          imageUrl: 'assets/images/food3.jpg',
          name: 'McDonald\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 120.00,
          categoryCode: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: ''),
      const Product(
          imageUrl: 'assets/images/food2.jpg',
          name: 'McDonald\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 70.00,
          categoryCode: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: ''),
    ];
  }
}
