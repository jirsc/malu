import 'package:doeat/modules/order/views/vendor_screen.dart';
import 'package:doeat/modules/search/widgets/search_filter.dart';
import 'package:doeat/utils/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:doeat/models/models.dart';
import 'package:doeat/modules/modules.dart';

class SearchList extends StatelessWidget {
  final List<Vendor> list;
  const SearchList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("nagrebuild si Searchlist");
    return Column(
      children: [
        SearchFilter(),
        const SizedBox(height: 30),
        ListView.separated(
            padding: const EdgeInsets.all(20),
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final vendor = list[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            VendorScreen(vendor: vendor) //DetailPage(vendor),
                        ),
                  );
                },
                child: SizedBox(
                  height: 120,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            vendor.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    vendor.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Icon(
                                  FontAwesome4.heart_empty,
                                  size: 20,
                                  color: Colors.orange[300]!,
                                ),
                              ],
                            ),
                            /* Text(
                              vendor.author,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ), */
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
                            Row(
                              children: [
                                _buildIconText(
                                  Icons.star,
                                  Colors.orange[300]!,
                                  '${vendor.score}(${vendor.ratingCount}k)',
                                ),
                              ],
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
                ),
              );
            },
            separatorBuilder: (_, index) => const SizedBox(height: 7),
            itemCount: list.length),
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
