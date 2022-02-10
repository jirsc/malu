import 'package:doeat/config/config.dart';
import 'package:doeat/utils/utils.dart';
import 'package:flutter/material.dart';

class SearchFilter extends StatelessWidget {
  SearchFilter({Key? key}) : super(key: key);

  final list = ['1', 'Sort By', 'Cuisines'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final filterLabel = list[index];
          return index == 0
              ? Wrap(
                  children: [
                    ChoiceChip(
                      selectedColor: theme.primaryColor,
                      selected: false,
                      label: const Icon(
                        FontAwesome4.sliders,
                        size: 20,
                        color: Colors.black87,
                      ),
                      onSelected: (selected) {
                        print('selected 1');
                      },
                      side: BorderSide(
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ],
                )
              : Wrap(
                  children: [
                    ChoiceChip(
                      selectedColor: theme.primaryColor,
                      selected: false,
                      label: Text(
                        filterLabel,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                        ),
                      ),
                      onSelected: (selected) {
                        print('selected 1');
                      },
                      side: BorderSide(
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ],
                );
        },
        separatorBuilder: (_, __) {
          return const SizedBox(
            width: 7,
          );
        },
        itemCount: list.length,
      ),
    );
  }
}
