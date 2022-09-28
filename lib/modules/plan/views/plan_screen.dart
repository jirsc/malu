import 'dart:math';

import 'package:flutter/material.dart';
import 'package:malu/modules/modules.dart';
import 'package:malu/utils/ui/icons/font_awesome_icons.dart';

//General Model
import '../../../models/models.dart';

class PlanScreen extends StatefulWidget {
  PlanScreen({Key? key}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late List<Product> productList;

  @override
  void initState() {
    // TODO: implement initState
    productList = Product.generateRandomListWhere(count: 4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      children: List.generate(4, (index) {
        if (index == 0) {
          return Card(
            child: IconButton(
              icon: const Icon(FontAwesome4.play_circled),
              onPressed: () {
                setState(() {
                  productList = Product.generateRandomListWhere(count: 4);
                });
              },
            ),
          );
        }
        return VerticalTileCard(
          product: productList[index],
        );
      }),
    );
  }
}

class VerticalTileCard extends StatelessWidget {
  const VerticalTileCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 140,
                  width: 140,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          //fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${product.price}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      /* Text(
                              product.description,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 7),
                            _buildIconText(
                              Icons.star,
                              Colors.orange[300]!,
                              '${vendor.score}(${vendor.ratingCount}k)',
                            ),
                            const SizedBox(width: 10),
                            _buildIconText(
                              Icons.visibility,
                              Colors.grey,
                              '${vendor.weeklyOrderCount}K Orders this week',
                            ), */
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
