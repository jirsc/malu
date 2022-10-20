import 'package:flutter/material.dart';
import 'package:malu/modules/explore/views/food_details_screen.dart';
import 'package:malu/modules/modules.dart';
import 'package:malu/models/models.dart';

class RecommendedUlam extends StatelessWidget {
  const RecommendedUlam(this.foodList, {Key? key}) : super(key: key);

  final List<Food>? foodList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CategoryTitle('Recommended for you'),
        SizedBox(
          height: 210,
          child: ListView.separated(
              padding: const EdgeInsets.all(20),
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  //VendorScreen(vendor: snapshot.data?[index]),
                                  FoodDetailsScreen(),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 130,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(
                                    image: NetworkImage(
                                        foodList?[index].imageUrl ??
                                            "assets/images/no_image.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Text(
                                  foodList?[index].name ?? "Got a null",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Text(
                                'P${foodList?[index].price.toStringAsFixed(2) ?? 'Got a null'}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: _buildIconText(
                          Icons.star,
                          Colors.orange[300]!,
                          '${foodList?[index].score ?? "Got a null"}',
                        ),
                      ),
                    ],
                  ),
              separatorBuilder: (_, index) => const SizedBox(
                    width: 15,
                  ),
              itemCount: 12), //foodList!.length),
        )
      ],
    );
  }

  Widget _buildIconText(IconData icon, Color color, String text) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 14,
          ),
          const SizedBox(width: 2),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
