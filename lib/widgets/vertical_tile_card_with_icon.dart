import 'package:flutter/material.dart';

typedef _IconButtonCallback = dynamic Function();

class VerticalTileCardWithIcon extends StatelessWidget {

  const VerticalTileCardWithIcon({
    Key? key,
    required this.imageUrl,
    required this.text1,
    this.text2 = '',
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String imageUrl;
  final String text1;
  final String text2;
  final Icon icon;
  final _IconButtonCallback onPressed;

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
                      imageUrl,
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
                        text1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          //fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        text2,
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
