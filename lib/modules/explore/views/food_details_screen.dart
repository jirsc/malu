import 'package:flutter/material.dart';

import '../../../utils/ui/icons/font_awesome_icons.dart';

class FoodDetailsScreen extends StatelessWidget {
  const FoodDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            FontAwesome4.angle_left,
            color: Colors.grey,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [],
        ),
      ),
      body: Container(
        child: Center(
          child: Text(':( Working on it. Tara kape muna tayo! ;)'),
        ),
      ),
    );
  }
}
