import 'package:equatable/equatable.dart';

/// {@template user}
/// Vendor model
///
/// [Vendor.empty] represents an unauthenticated user.
/// {@endtemplate}
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
  final String description;

  const Vendor({
    required this.id,
    this.imageUrl = '',
    this.name = '',
    this.distance = '',
    this.score = 0,
    this.ratingCount = 0,
    this.weeklyOrderCount = 0,
    this.category = const [''],
    this.description = '',
  });

  /// Empty user which represents an unauthenticated user.
  static const empty = Vendor(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == Vendor.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get hasData => this != Vendor.empty;

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
      ];

  static List<Vendor> generateRecommendedVendor() {
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

  static List<Vendor> generateTrendingVendor() {
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
          id: '1'),
      const Vendor(
          imageUrl: 'assets/images/food4.jpg',
          name: 'Coco Fresh',
          distance: 'COCO FRESH',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '2'),
      const Vendor(
          imageUrl: 'assets/images/food3.jpg',
          name: 'Mary Grace',
          distance: 'MARY GRACE',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '3'),
      const Vendor(
          imageUrl: 'assets/images/food2.jpg',
          name: 'Chatime',
          distance: 'CHATIME',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '4'),
      const Vendor(
          imageUrl: 'assets/images/food2.jpg',
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
