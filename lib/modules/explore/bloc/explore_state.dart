part of 'explore_bloc.dart';

enum ExploreStatus {
  initial,
  loading,
  loaded, // also means "success"
  error,
}

extension ExploreStatusX on ExploreStatus {
  bool get isInitial => this == ExploreStatus.initial;
  bool get isLoading => this == ExploreStatus.loading;
  bool get isLoaded => this == ExploreStatus.loaded;
  bool get isError => this == ExploreStatus.error;
}

class ExploreState extends Equatable {
  const ExploreState({
    this.status = ExploreStatus.initial,
    List<Food>? foods,
    User? user,
  })  : foods = foods ?? const [],
        user = user ?? User.empty;

  final ExploreStatus status;
  final List<Food> foods;
  final User user;

  @override
  List<Object> get props => [status, foods, user];

  ExploreState copyWith({
    ExploreStatus? status,
    List<Food>? foods,
    User? user,
  }) {
    return ExploreState(
      status: status ?? this.status,
      foods: foods ?? this.foods,
      user: user ?? this.user,
    );
  }
}
