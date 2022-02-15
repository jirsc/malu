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
    List<Vendor>? vendors,
    User? user,
  })  : vendors = vendors ?? const [],
        user = user ?? User.empty;

  final ExploreStatus status;
  final List<Vendor> vendors;
  final User user;

  @override
  List<Object> get props => [status, vendors, user];

  ExploreState copyWith({
    ExploreStatus? status,
    List<Vendor>? vendors,
    User? user,
  }) {
    return ExploreState(
      status: status ?? this.status,
      vendors: vendors ?? this.vendors,
      user: user ?? this.user,
    );
  }
}
