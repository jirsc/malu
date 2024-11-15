import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:malu/app/bloc/app_bloc.dart';
import 'package:malu/config/config.dart';
import 'package:malu/models/food.dart';
import 'package:malu/modules/plan/plan.dart';
import 'package:malu/utils/helpers/date_time_helper.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../utils/services/firebase_firestore_service.dart';

class WeekViewCalendar extends StatefulWidget {
  const WeekViewCalendar({Key? key, required this.selectedDay})
      : super(key: key);

  final DateTime selectedDay;

  @override
  State<WeekViewCalendar> createState() => _WeekViewCalendarState();
}

class _WeekViewCalendarState extends State<WeekViewCalendar> {
  final FirebaseFirestoreService dbService = FirebaseFirestoreService();

  final DateTime _today = DateTime.now();
  late final DateTime _firstDay;
  late final DateTime _lastDay;

  late CalendarFormat _calendarFormat;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();

    _firstDay = DateTime(_today.year, _today.month - 3, _today.day);
    _lastDay = DateTime(_today.year, _today.month + 2, _today.day);
    _focusedDay = widget.selectedDay;
    _selectedDay = widget.selectedDay;

    _calendarFormat = CalendarFormat.week;
  }

  String _calendarTextHeader(DateTime date, dynamic locale) {
    String calendarHeader = DateFormat.yM(locale).format(date);
    String firstDateInWeek = formatDateToString(
        date: findFirstDateOfTheWeek(dateTime: date), format: 'MMMM d');
    String lastDateInWeek = formatDateToString(
        date: findLastDateOfTheWeek(dateTime: date), format: 'MMMM d');

    try {
      if (findFirstDateOfTheWeek(dateTime: date).day > 0 &&
          findLastDateOfTheWeek(dateTime: date).day > 0) {
        calendarHeader = "$firstDateInWeek - $lastDateInWeek";
      }
    } catch (error) {
      if (kDebugMode) print('_calendarHeader $error');
      rethrow;
    }

    return calendarHeader;
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: _firstDay,
      lastDay: _lastDay,
      calendarFormat: _calendarFormat,
      headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextFormatter: _calendarTextHeader,
          titleTextStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
      startingDayOfWeek: StartingDayOfWeek.monday,
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.visible,
        ),
        weekendStyle: TextStyle(
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.visible,
        ),
      ),
      calendarStyle: CalendarStyle(
        cellPadding: const EdgeInsets.symmetric(vertical: 4.0),
        todayDecoration: BoxDecoration(
          color: theme.primaryColorDark,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: theme.primaryColor,
          shape: BoxShape.circle,
        ),
      ),
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
        print(_selectedDay);
        context.read<PlanBloc>().add(SelectedDateChanged(
              user: user,
              date:
                  "${selectedDay.year}${selectedDay.month}${selectedDay.day.toString().padLeft(2, "0")}",
            ));
      },
    );
  }
}
