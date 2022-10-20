import 'package:flutter/material.dart';

class CategoryTitle extends StatelessWidget {
  const CategoryTitle(this.title, {Key? key}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: (() {
              SnackBar snackBar = const SnackBar(
                content: Text('Let\'s see more food later ah, okay lang?'),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }),
            child: const Text(
              'See more',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
