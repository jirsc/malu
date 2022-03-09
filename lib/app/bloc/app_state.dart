part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  userEmailUnverified,
  pinLocked,
  unauthenticated,
}

extension AppStatusX on AppStatus {
  bool get isLocked => this == AppStatus.pinLocked;
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
  });

  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.userEmailUnverified(User user)
      : this._(status: AppStatus.userEmailUnverified, user: user);

  const AppState.pinLocked(User user)
      : this._(status: AppStatus.pinLocked, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
