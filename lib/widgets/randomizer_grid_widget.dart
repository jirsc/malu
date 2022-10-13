import 'package:flutter/material.dart';
import 'package:malu/utils/utils.dart';

import '../models/food.dart';
import 'vertical_tile_card.dart';

class RandomizerGrid extends StatefulWidget {
  final List<Food> foodList;
  final int listCount;

  const RandomizerGrid({
    Key? key,
    required this.foodList,
    required this.listCount,
  }) : super(key: key);

  @override
  State<RandomizerGrid> createState() => _RandomizerGridState();
}

class _RandomizerGridState extends State<RandomizerGrid> {
  late List<Food> itemList;

  @override
  void initState() {
    itemList = widget.foodList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      children: List.generate(widget.listCount, (index) {
        if (index == 0) {
          return Card(
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    FontAwesome4.play_circled,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      itemList = (widget.foodList.toSet().toList()..shuffle())
                          .take(widget.listCount)
                          .toList();
                    });
                  },
                ),
                Text('Randomize'),
              ],
            ),
          );
        }
        return VerticalTileCard(
          imageUrl: itemList[index].imageUrl,
          text1: itemList[index].name,
          text2: itemList[index].price.toString(),
        );
      }),
    );
  }
}