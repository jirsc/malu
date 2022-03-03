part of 'phone_auth_bloc.dart';

class PhoneAuthEvent extends Equatable {
  const PhoneAuthEvent();

  @override
  List<Object> get props => [];
}

class NumberInputChanged extends PhoneAuthEvent {
  const NumberInputChanged({
    required this.text,
  });
  final String text;

  @override
  List<Object> get props => [text];
}
