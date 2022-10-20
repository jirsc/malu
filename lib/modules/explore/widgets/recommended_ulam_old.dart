import 'package:flutter/material.dart';
import 'package:malu/modules/explore/views/food_details_screen.dart';
import 'package:malu/modules/modules.dart';
import 'package:malu/models/models.dart';
import 'package:malu/utils/services/firebase_firestore_service.dart';

class RecommendedUlam extends StatelessWidget {
  const RecommendedUlam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Food>>(
        future: FirebaseFirestoreService().getListOfFoods(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image(
                                            image: NetworkImage(snapshot
                                                    .data?[index].imageUrl ??
                                                "assets/images/no_image.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: Text(
                                          snapshot.data?[index].name ??
                                              "Got a null",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        snapshot.data?[index].price
                                                .toString() ??
                                            "Got a null",
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
                                  '${snapshot.data?[index].score ?? "Got a null"}',
                                ),
                              ),
                            ],
                          ),
                      separatorBuilder: (_, index) => const SizedBox(
                            width: 15,
                          ),
                      itemCount: 12), //snapshot.data!.length),
                )
              ],
            );
          } else {
            // TODO: SKELETON LOADING

            return CircularProgressIndicator();
          }
        });
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
