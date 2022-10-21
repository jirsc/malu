import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malu/app/bloc/app_bloc.dart';
import 'package:malu/config/config.dart';
import 'package:malu/modules/modules.dart';
import 'package:malu/utils/helpers/date_time_helper.dart';
import 'package:malu/widgets/randomizer_grid_widget.dart';

import '../../../utils/services/firebase_firestore_service.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  final FirebaseFirestoreService dbService = FirebaseFirestoreService();
  late Map daysInWeek;
  late String _today;

  @override
  void initState() {
    _today = formatDateToString(date: DateTime.now(), format: 'yyyyMMdd');
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
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return BlocProvider(
      create: (context) => PlanBloc(),
      child: BlocBuilder<PlanBloc, PlanState>(builder: (context, state) {
        if (state.status.doesSelectedDateChanged ||
            state.status.isMealPlanUpdated) {
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
                    WeekViewCalendar(selectedDay: DateTime.parse(state.date)),
                    const Divider(
                      thickness: 1,
                      indent: 21.0,
                      endIndent: 21.0,
                    ),
                    Expanded(
                      child: RandomizerGrid(
                        foodList: state.foodList,
                        date: state.date,
                        user: user,
                        listCount: 4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
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
                            onPressed: () => context.read<PlanBloc>().add(
                                  MealPlanUpdated(
                                    user: user,
                                    date: state.date,
                                    foodList: state.foodList,
                                  ),
                                ),
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
        } else if (state.status.isLoading) {
          return PlanScreenSkeleton();
        } else {
          context
              .read<PlanBloc>()
              .add(SelectedDateChanged(user: user, date: _today));
          return Container();
        }
      }),
    );
  }
}
