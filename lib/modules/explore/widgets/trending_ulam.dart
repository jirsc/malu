import 'package:authentication_repository/authentication_repository.dart';
import 'package:malu/modules/explore/views/food_details_screen.dart';
import 'package:malu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:malu/models/models.dart';
import 'package:malu/modules/modules.dart';

import '../../../utils/helpers/number_helper.dart';

class TrendingUlam extends StatefulWidget {
  const TrendingUlam({Key? key, required this.user, required this.foodList})
      : super(key: key);

  final User user;
  final List<Food>? foodList;

  @override
  State<TrendingUlam> createState() => _TrendingUlamState();
}

class _TrendingUlamState extends State<TrendingUlam> {
  final FirebaseFirestoreService dbService = FirebaseFirestoreService();

  bool isAddedToFavorites = false;

  @override
  Widget build(BuildContext context) {
    //var uid = context.read<AuthenticationRepository>().currentUser.id;
    return Column(
      children: [
        const CategoryTitle('Trending Ulam'),
        ListView.separated(
            padding: const EdgeInsets.all(20),
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final food = widget.foodList?[index] ?? Food.empty;
              return SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(child: _buildClickableRow(context, food)),
                    /* SizedBox(
                      width: 30,
                      child: _buildClickableHeartIcon(vendor),
                    ), */
                  ],
                ),
              );
            },
            separatorBuilder: (_, index) => const SizedBox(height: 20),
            itemCount: widget.foodList!.length),
      ],
    );
  }

  Widget _buildClickableRow(BuildContext context, Food? food) {
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
          Column(
            children: [
              SizedBox(
                height: 100,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: NetworkImage(
                        food?.imageUrl ?? "assets/images/no_image.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food?.name ?? "Got a null",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  food?.description ?? "Got a null",
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
                  '${food?.score ?? 'Got a null'}(${numberToCompact(food?.ratingCount ?? 0)})',
                ),
                // const SizedBox(width: 10),
                // _buildIconText(
                //   Icons.visibility,
                //   Colors.grey,
                //   '${vendor.weeklyOrderCount}K Orders this week',
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClickableHeartIcon(Vendor vendor) {
    isAddedToFavorites =
        widget.user.favoriteVendor?.contains(vendor.id) ?? false;
    return Column(
      children: [
        IconButton(
          padding: const EdgeInsets.all(0),
          alignment: Alignment.topCenter,
          onPressed: () {
            if (widget.user.favoriteVendor?.contains(vendor.id) ?? false) {
              widget.user.favoriteVendor?.remove(vendor.id);
            } else {
              widget.user.favoriteVendor?.add(vendor.id);
            }
            setState(() {
              isAddedToFavorites = !isAddedToFavorites;
            });
          },
          icon: Icon(
            isAddedToFavorites ? FontAwesome4.heart : FontAwesome4.heart_empty,
            size: 20,
            color: Colors.orange[300]!,
          ),
        )
      ],
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
