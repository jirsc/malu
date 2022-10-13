part of 'plan_bloc.dart';

enum PlanStatus {
  initial,
  loading,
  dataLoaded, // also means "success"
  mealPlanUpdated,
  selectedDateChanged,
  error,
}

extension PlanStatusX on PlanStatus {
  bool get isInitial => this == PlanStatus.initial;
  bool get isLoading => this == PlanStatus.loading;
  bool get isDataLoaded => this == PlanStatus.dataLoaded;
  bool get isMealPlanUpdated => this == PlanStatus.mealPlanUpdated;
  bool get doesSelectedDateChanged => this == PlanStatus.selectedDateChanged;
  bool get isError => this == PlanStatus.error;
}

class PlanState extends Equatable {
  const PlanState({
    this.status = PlanStatus.initial,
    User? user,
    List<Food>? foodList,
  })  : user = user ?? User.empty,
        foodList = foodList ?? const [];

  final PlanStatus status;
  final User user;
  final List<Food> foodList;

  @override
  List<Object> get props => [status, foodList, user];

  PlanState copyWith({
    PlanStatus? status,
    User? user,
    List<Food>? foodList,
  }) {
    return PlanState(
      status: status ?? this.status,
      user: user ?? this.user,
      foodList: foodList ?? this.foodList,
    );
  }
}
