import 'package:doeat/modules/order/views/vendor_screen.dart';
import 'package:doeat/modules/search/widgets/search_filter.dart';
import 'package:doeat/utils/ui/ui.dart';
import 'package:doeat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:doeat/models/models.dart';
import 'package:doeat/modules/modules.dart';

class SearchList extends StatelessWidget {
  final List<Vendor> list;
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
              final vendor = list[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(child: _buildClickableRow(context, vendor)),
                  ],
                ),
              );
            },
            separatorBuilder: (_, index) => Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                height: 7,
                child: const Skeleton()),
            itemCount: list.length),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vendor.name + ' - address',
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
