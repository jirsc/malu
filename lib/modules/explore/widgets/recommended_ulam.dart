import 'package:flutter/material.dart';
import 'package:malu/modules/modules.dart';
import 'package:malu/models/models.dart';

class RecommendedUlam extends StatelessWidget {
  final recommendedList = Vendor.generateRecommendedVendor();
  RecommendedUlam({Key? key}) : super(key: key);

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
                                  VendorScreen(vendor: recommendedList[index]),
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
                                  child: Image.asset(
                                    recommendedList[index].imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Text(
                                  recommendedList[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Text(
                                recommendedList[index].distance,
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
                          '${recommendedList[index].score}',
                        ),
                      ),
                    ],
                  ),
              separatorBuilder: (_, index) => const SizedBox(
                    width: 15,
                  ),
              itemCount: recommendedList.length),
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
