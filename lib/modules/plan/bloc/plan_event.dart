part of 'plan_bloc.dart';

abstract class PlanEvent extends Equatable {
  const PlanEvent();

  @override
  List<Object> get props => [];
}

class DataLoaded extends PlanEvent {
  const DataLoaded({
    required this.user,
  });
  final User user;

  @override
  List<Object> get props => [user];
}

class SelectedDateChanged extends PlanEvent {
  const SelectedDateChanged({
    required this.user,
    required this.date,
    required this.foodList,
  });
  final User user;
  final String date;
  final List<Food> foodList;

  @override
  List<Object> get props => [user, foodList];
}

class MealPlanUpdated extends PlanEvent {
  const MealPlanUpdated({
    required this.user,
    required this.foodList,
  });
  final User user;
  final List<Food> foodList;

  @override
  List<Object> get props => [user, foodList];
}
