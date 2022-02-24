import 'package:doeat/models/models.dart';

enum ProductCategory { latest, trending, recommended }

class ProductSection {
  final String title;
  final List<Product> product;
  final ProductCategory productCategory;
  bool isLoading = false;
  bool isCompletelyFetched = false;

  ProductSection({
    required this.productCategory,
    required this.title,
    required this.product,
  });

  static List<ProductSection> generateProductSectionList() {
    return [
      ProductSection(
        title: 'Recommended for you',
        productCategory: ProductCategory.recommended,
        product: Product.generateProductList(),
      ),
      ProductSection(
        title: 'New Items',
        productCategory: ProductCategory.latest,
        product: Product.generateProductList(),
      ),
      ProductSection(
        title: 'Hot and Trending',
        productCategory: ProductCategory.trending,
        product: Product.generateTrendingProduct(),
      ),
      ProductSection(
        title: 'Hot and Trending',
        productCategory: ProductCategory.trending,
        product: Product.generateProductList(),
      ),
    ];
  }
}
