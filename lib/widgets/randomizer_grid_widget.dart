import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malu/modules/modules.dart';
import 'package:malu/repositories/food_repository.dart';
import 'package:malu/utils/utils.dart';
import 'package:malu/widgets/vertical_tile_card_with_icon.dart';

import '../models/food.dart';
import '../modules/explore/views/food_details_screen.dart';

class RandomizerGrid extends StatefulWidget {
  const RandomizerGrid({
    Key? key,
    required this.foodList,
    required this.date,
    required this.user,
    required this.listCount,
  }) : super(key: key);

  final List<Food> foodList;
  final String date;
  final User user;
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
          if (index == widget.listCount - 1) {
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
                    onPressed: () async {
                      context.read<PlanBloc>().add(SelectedDateChanged(
                            user: widget.user,
                            date: widget.date,
                            foodList: await randomizedList(),
                          ));
                    },
                  ),
                  const Text('Randomize'),
                ],
              ),
            );
          } else {
            return buildVerticalTileCard(itemList, index);
          }
        }),
      );
    });
  }

  Widget buildVerticalTileCard(List<Food> itemList, int index) {
    List<String> mealType = ['BREAKFAST', 'LUNCH', 'DINNER'];
    return VerticalTileCardWithIcon(
      imageUrl: itemList[index].imageUrl,
      text1: mealType[index],
      text2: itemList[index].name,
      icon: const Icon(FontAwesome4.edit),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FoodDetailsScreen(),
          ),
        );
      },
    );
  }

  Future<List<Food>> randomizedList() async {
    // List<Food> _list = [];
    // int count = 0;
    // return (widget.foodList.toSet().toList()..shuffle())
    //.take(widget.listCount)
    // .toList();
    // List<Food> foodList;
    if (itemList.length <= widget.listCount) {
      FoodRepository foodRepository =
          FoodRepository(service: FirebaseFirestoreService());
      final foodList = foodRepository.foodList.isEmpty
          ? await foodRepository.getFoods()
          : foodRepository.foodList;
      return (foodList.toSet().toList()..shuffle()).toList();
    } else {
      return (itemList.toSet().toList()..shuffle()).toList();
    }
  }
}
