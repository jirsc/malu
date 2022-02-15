import 'package:authentication_repository/authentication_repository.dart';
import 'package:doeat/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:doeat/models/models.dart';
import 'package:doeat/modules/modules.dart';

class TrendingVendor extends StatefulWidget {
  const TrendingVendor({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<TrendingVendor> createState() => _TrendingVendorState();
}

class _TrendingVendorState extends State<TrendingVendor> {
  final FirebaseFirestoreService dbService = FirebaseFirestoreService();

  final List<Vendor> trendingList = Vendor.generateTrendingVendor();
  bool isAddedToFavorites = false;

  @override
  Widget build(BuildContext context) {
    //var uid = context.read<AuthenticationRepository>().currentUser.id;
    return Column(
      children: [
        const CategoryTitle('Trending Vendor'),
        ListView.separated(
            padding: const EdgeInsets.all(20),
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final vendor = trendingList[index];
              return SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(child: _buildClickableRow(context, vendor)),
                    /* SizedBox(
                      width: 30,
                      child: _buildClickableHeartIcon(vendor),
                    ), */
                  ],
                ),
              );
            },
            separatorBuilder: (_, index) => const SizedBox(height: 20),
            itemCount: trendingList.length),
      ],
    );
  }

  Widget _buildClickableRow(BuildContext context, Vendor vendor) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VendorScreen(vendor: vendor),
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
                  child: Image.asset(
                    vendor.imageUrl,
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
                  vendor.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  vendor.description,
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
                ),
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
