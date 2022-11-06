import 'package:malu/modules/search/widgets/search_filter.dart';
import 'package:malu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:malu/models/models.dart';

import '../../../constants/app_constants.dart';
import '../../../utils/helpers/number_helper.dart';
import '../../explore/views/food_details_screen.dart';

class SearchList extends StatelessWidget {
  final List<Food> list;
  const SearchList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final food = list[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(child: _buildClickableRow(context, food)),
                  ],
                ),
              );
            },
            separatorBuilder: (_, index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  height: 7,
                  child: Container(
                    padding: const EdgeInsets.all(defaultPadding / 2),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.04),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(defaultPadding))),
                  ),
                ),
            itemCount: list.length),
      ],
    );
  }

  Widget _buildClickableRow(BuildContext context, Food food) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FoodDetailsScreen(),
          ),
        );
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name + ' - address',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  food.description,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 7),
                _buildIconText(
                  Icons.star,
                  Colors.orange[300]!,
                  '${food.score}(${numberToCompact(food.ratingCount)})',
                ),
                const SizedBox(width: 10),
                _buildIconText(
                  Icons.visibility,
                  Colors.grey,
                  '${numberToCompact(food.ratingCount)} votes this week',
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 100,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: NetworkImage(food.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconText(IconData icon, Color color, String text) {
    return Row(
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
          ),
        ),
      ],
    );
  }
}
