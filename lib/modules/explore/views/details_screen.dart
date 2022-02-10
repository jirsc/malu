import 'package:doeat/models/models.dart';
import 'package:doeat/utils/ui/ui.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Vendor vendor;
  const DetailPage(this.vendor, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            FontAwesome4.angle_left,
            color: Colors.black54,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 550,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                  child: Image.asset(
                    vendor.imageUrl,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 250),
                child: Text(
                  vendor.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                vendor.distance,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIconText(
                    Icons.star,
                    Colors.orange[300]!,
                    '${vendor.score}(${vendor.ratingCount}k)',
                  ),
                  const SizedBox(width: 10),
                  _buildIconText(
                    Icons.visibility,
                    Colors.white,
                    '${vendor.weeklyOrderCount}K Orders this week',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: vendor.category
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Chip(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          label: Text(e),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 35,
                ),
                child: Text(vendor.description),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton(
                      Icons.add,
                      Colors.grey[800]!,
                      'Add To Library',
                    ),
                    const SizedBox(width: 15),
                    _buildButton(
                      Icons.menu_book,
                      const Color(0xFF6741FF),
                      'Read Now',
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, Color color, String text) {
    return SizedBox(
      height: 40,
      width: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 5),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
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
