import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// To generate the food.g.dart file run:
// 'flutter pub run build_runner build'
//  in the project root.
part 'food.g.dart';

enum FoodCategory {
  recommended, // Suggested by the vendor
  trending, // Famous and mostly bought by the customers
  latest, // New products
  top, // Top rated and most liked by the customers
  //////////////////////////////////////////////////
  fish,
  chicken,
  pork,
  beef,
  vegetable,
  pasta,
  seafood,
  pastry,
  fruit,
  grain,
  dairy
}

enum MealType { breakfast, lunch, dinner, snack, dessert, appetizer }

enum Flavor {
  sweet,
  sour,
  salty,
  bitter,
  savoury, // also means 'umami'
  spicy
}

enum FoodMoisture { soup, sauce, dry }

enum CookingMethod {
  gisa, // saute in english
  sinabawan,
  sauce,
  sigang,
  adobo,
  ginataan,
  tomatoSauce,
  fried,
  grilled,
  steamed,
  roasted,
  boiled,
  baked,
  poached,
  simmered,
  broiled,
  blanched,
  braised,
  stewed
}

enum Cuisines { local, foreign }

// enum EntryType { login, signUp }

// extension EntryTypeX on EntryType {
//   bool get isLogin => this == EntryType.login;
//   bool get isSignUp => this == EntryType.signUp;
// }

/// {@template product}
/// Food model
///
/// [Food.empty] represents an empty product.
/// {@endtemplate}
///
@JsonSerializable()
class Food extends Equatable {
  /// {@macro product}
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final List<Map<String, dynamic>> specification;
  final List<String> category;
  final List<String> mealType;
  final double score;
  final num ratingCount;
  final bool recommended;

  const Food({
    this.id = '',
    required this.name,
    required this.price,
    this.imageUrl = '',
    this.description = '',
    this.specification = const [{}],
    this.category = const [''],
    this.mealType = const [''],
    this.score = 0,
    this.ratingCount = 0,
    this.recommended = false,
  });

  /// Empty product
  static const empty = Food(id: '', name: '', price: 0);

  /// Convenience getter to determine whether the current product is empty.
  bool get isEmpty => this == Food.empty;

  /// Convenience getter to determine whether the current product is not empty.
  bool get hasData => this != Food.empty;

  /// Convenience getter to determine whether the current product is available.
  bool get isRecommended => recommended == true;

  factory Food.fromJson(Map<String, dynamic> json) {
    return _$FoodFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FoodToJson(this);

  factory Food.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    return Food.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        imageUrl,
        description,
        specification,
        category,
        mealType,
        score,
        ratingCount,
        recommended,
      ];

  static List<Food> generateRandomListWhere({required int count}) {
    // Convert List to Set to remove duplicates
    // Convert back to list then shuffle items
    // Get number of items based on variable 'count'
    return (generateRecommendedFood().toSet().toList()..shuffle())
        .take(count)
        .toList();
  }

  static List<Food> listWhere({required FoodCategory category}) {
    switch (category) {
      case FoodCategory.recommended:
        return generateRecommendedFood();
      case FoodCategory.trending:
        return generateTrendingFood();
      case FoodCategory.latest:
      case FoodCategory.top:
      default:
        return generateFoodList();
    }
  }

  static List<Food> generateRecommendedFood() {
    return [
      const Food(
          imageUrl: 'assets/images/food1.jpg',
          name: 'McDonald\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '1'),
      const Food(
          imageUrl: 'assets/images/food4.jpg',
          name: 'Coco Fresh',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '2'),
      const Food(
          imageUrl: 'assets/images/food3.jpg',
          name: 'Mary Grace',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '3'),
      const Food(
          imageUrl: 'assets/images/food2.jpg',
          name: 'Chatime',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '4'),
      const Food(
          imageUrl: 'assets/images/food1.jpg',
          name: 'Conti\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '5'),
      const Food(
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

  static List<Food> generateTrendingFood() {
    return [
      const Food(
          imageUrl: 'assets/images/food1.jpg',
          name: 'McDonald\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '1'),
      const Food(
          imageUrl: 'assets/images/food4.jpg',
          name: 'Coco Fresh',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '2'),
      const Food(
          imageUrl: 'assets/images/food3.jpg',
          name: 'Mary Grace',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '3'),
      const Food(
          imageUrl: 'assets/images/food2.jpg',
          name: 'Chatime',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '4'),
      const Food(
          imageUrl: 'assets/images/food1.jpg',
          name: 'Conti\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '5'),
      const Food(
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

  static List<Food> generateFoodList() {
    return [
      const Food(
          imageUrl: 'assets/images/food1.jpg',
          name: 'McDonald\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 90.00,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: ''),
      const Food(
          imageUrl: 'assets/images/food4.jpg',
          name: 'McDonald\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 85.00,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: ''),
      const Food(
          imageUrl: 'assets/images/food3.jpg',
          name: 'McDonald\'s',
          score: 4.9,
          ratingCount: 107.3,
          price: 120.00,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: ''),
      const Food(
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
