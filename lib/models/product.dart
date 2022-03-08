import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'product.g.dart';

enum ProductCategory {
  recommended, // Suggested by the vendor
  trending, // Famous and mostly bought by the customers
  latest, // New products
  top, // Top rated and most liked by the customers
}

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
  final List<String> category;
  final List<List<String>> specification;
  final bool isRecommended;

  const Product({
    required this.id,
    this.imageUrl = '',
    this.name = '',
    this.price = 0,
    this.score = 0,
    this.ratingCount = 0,
    this.description = '',
    this.category = const [''],
    this.specification = const [
      ['']
    ],
    this.isRecommended = false,
  });

  /// Empty product
  static const empty = Product(id: '');

  /// Convenience getter to determine whether the current product is empty.
  bool get isEmpty => this == Product.empty;

  /// Convenience getter to determine whether the current product is not empty.
  bool get hasData => this != Product.empty;

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
        category,
        isRecommended,
      ];

  static List<Product> listWhere({required ProductCategory category}) {
    switch (category) {
      case ProductCategory.recommended:
        return generateRecommendedProduct();
      case ProductCategory.trending:
        return generateTrendingProduct();
      case ProductCategory.latest:
      case ProductCategory.top:
      default:
        return generateProductList();
    }
  }

  static List<Product> generateRecommendedProduct() {
    return [
      const Product(
          imageUrl: 'assets/images/food1.jpg',
          name: 'McDonald\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '1'),
      const Product(
          imageUrl: 'assets/images/food4.jpg',
          name: 'Coco Fresh',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '2'),
      const Product(
          imageUrl: 'assets/images/food3.jpg',
          name: 'Mary Grace',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '3'),
      const Product(
          imageUrl: 'assets/images/food2.jpg',
          name: 'Chatime',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '4'),
      const Product(
          imageUrl: 'assets/images/food1.jpg',
          name: 'Conti\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '5'),
      const Product(
          imageUrl: 'assets/images/food4.jpg',
          name: 'Cabalen',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
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
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '1'),
      const Product(
          imageUrl: 'assets/images/food4.jpg',
          name: 'Coco Fresh',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '2'),
      const Product(
          imageUrl: 'assets/images/food3.jpg',
          name: 'Mary Grace',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '3'),
      const Product(
          imageUrl: 'assets/images/food2.jpg',
          name: 'Chatime',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '4'),
      const Product(
          imageUrl: 'assets/images/food1.jpg',
          name: 'Conti\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '5'),
      const Product(
          imageUrl: 'assets/images/food4.jpg',
          name: 'Cabalen',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
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
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: ''),
      const Product(
          imageUrl: 'assets/images/food4.jpg',
          name: 'McDonald\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 85.00,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: ''),
      const Product(
          imageUrl: 'assets/images/food3.jpg',
          name: 'McDonald\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 120.00,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: ''),
      const Product(
          imageUrl: 'assets/images/food2.jpg',
          name: 'McDonald\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 70.00,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: ''),
    ];
  }
}
