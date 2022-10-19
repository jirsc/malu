import 'package:flutter/material.dart';

class DayPlan extends StatelessWidget {
  final String dayTitle;

  const DayPlan({Key? key, required this.dayTitle}) : super(key: key);

  Widget ExpansionDayTile() {
    String myMenu = "Not yet available..";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ExpansionTile(
        title: Text(
          dayTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          //This part is just for test.
          //You are free to create the widget here to suit for the menu.
          ListTile(
            title: Text("For Breakfast:   $myMenu"),
          ),
          ListTile(
            title: Text("For Lunch:   $myMenu"),
          ),
          ListTile(
            title: Text("For Dinner:  $myMenu"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [Expanded(child: ExpansionDayTile())],
        )
      ],
    );
  }
}
