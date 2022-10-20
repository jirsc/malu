import 'package:flutter/material.dart';
import 'package:malu/utils/utils.dart';
import 'package:malu/widgets/vertical_tile_card_with_icon.dart';

import '../models/food.dart';

class RandomizerGrid extends StatefulWidget {
  const RandomizerGrid({
    Key? key,
    required this.foodList,
    required this.listCount,
  }) : super(key: key);

  final List<Food> foodList;
  final int listCount;

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
    return LayoutBuilder(builder: (context, constraints) {
      return GridView.count(
        clipBehavior: Clip.none,
        mainAxisSpacing: constraints.maxWidth > 500 ? 7 : 12,
        //scrollDirection:
        //  constraints.maxWidth > 500 ? Axis.horizontal : Axis.vertical,
        // physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: constraints.maxWidth > 500 ? 4 : 2,
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
                        itemList = randomizedList();
                      });
                    },
                  ),
                  const Text('Randomize'),
                ],
              ),
            );
          }
          return buildVerticalTileCard(itemList, index);
        }),
      );
    });
  }

  Widget buildVerticalTileCard(List<Food> itemList, int index) {
    List<String> mealType = ['', 'BREAKFAST', 'LUNCH', 'DINNER'];
    return VerticalTileCardWithIcon(
      imageUrl: itemList[index].imageUrl,
      text1: mealType[index],
      text2: itemList[index].name,
      icon: const Icon(FontAwesome4.edit),
      onPressed: () {
        print('text to');
      },
    );
  }

  List<Food> randomizedList() {
    List<Food> _list = [];
    int count = 0;
    return (widget.foodList.toSet().toList()..shuffle())
        .take(widget.listCount)
        .toList();
  }
}
