part of 'phone_auth_bloc.dart';

enum PhoneAuthStatus {
  initial,
  loading,
  valid,
  invalid,
  error,
}

extension PhoneAuthStatusX on PhoneAuthStatus {
  bool get isInitial => this == PhoneAuthStatus.initial;
  bool get isLoading => this == PhoneAuthStatus.loading;
  bool get isValid => this == PhoneAuthStatus.valid;
  bool get isInvalid => this == PhoneAuthStatus.invalid;
  bool get hasError => this == PhoneAuthStatus.error;
}

class PhoneAuthState extends Equatable {
  /* const PhoneAuthState({
    this.status = PhoneAuthStatus.initial,
    List<Vendor>? vendors,
    User? user,
  })  : vendors = vendors ?? const [],
        user = user ?? User.empty; */

  const PhoneAuthState({
    this.status = PhoneAuthStatus.initial,
  });

  final PhoneAuthStatus status;
  //final List<Vendor> vendors;
  //final User user;

  @override
  List<Object> get props => [status]; //, vendors, user];

  PhoneAuthState copyWith({
    PhoneAuthStatus? status,
    //List<Vendor>? vendors,
    //User? user,
  }) {
    return PhoneAuthState(
      status: status ?? this.status,
      //vendors: vendors ?? this.vendors,
      //user: user ?? this.user,
    );
  }
}
