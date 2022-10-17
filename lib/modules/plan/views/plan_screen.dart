import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malu/config/config.dart';
import 'package:malu/modules/modules.dart';
import 'package:malu/utils/ui/icons/font_awesome_icons.dart';
import 'package:malu/widgets/randomizer_grid_widget.dart';

//General Model
import '../../../models/models.dart';

//Widgets
import 'package:malu/widgets/vertical_tile_card.dart';
//import 'day_plan_widget.dart';
import 'day_plan_widget.dart';
import 'week_view_calendar_widget.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late List<Food> productList;
  late Map daysInWeek;

  @override
  void initState() {
    productList = Food.generateRandomListWhere(count: 4);
    super.initState();

    // It should not be like this. XD
    // It's for testing purposes only.
    daysInWeek = {
      1: "Monday",
      2: "Tuesday",
      3: "Wednesday",
      4: "Thursday",
      5: "Friday",
      6: "Saturday",
      7: "Sunday"
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlanBloc(),
      child: BlocBuilder<PlanBloc, PlanState>(builder: (context, state) {
        if (state.status.isMealPlanUpdated && state.foodList.isNotEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "My Meal Plan",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: SafeArea(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  children: const [
                    WeekViewCalendar(),
                    Divider(
                      thickness: 1,
                      indent: 25.0,
                      endIndent: 25.0,
                    ),
                  ],
                ),
              ),
            ),
          );

          // TODO : UPDATE DATABASE WHEN SAVED

        } else if (state.status.doesSelectedDateChanged) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "My Meal Plan",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: SafeArea(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  children: [
                    const WeekViewCalendar(),
                    const Divider(
                      thickness: 1,
                      indent: 25.0,
                      endIndent: 25.0,
                    ),
                    Expanded(
                      child: RandomizerGrid(
                        foodList: state.foodList,
                        listCount: 4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                                side: BorderSide.none,
                              ),
                              primary: theme.primaryColor,
                              elevation: 0,
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "My Meal Plan",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: SafeArea(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  children: [
                    const WeekViewCalendar(),
                    const Divider(
                      thickness: 1,
                      indent: 25.0,
                      endIndent: 25.0,
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ListView.builder(
                          itemCount: daysInWeek.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child:
                                    DayPlan(dayTitle: daysInWeek[index + 1]));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
