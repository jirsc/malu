import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'phone_auth_event.dart';
part 'phone_auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  PhoneAuthBloc() : super(PhoneAuthState()) {
    on<NumberInputChanged>(_onNumberInputChanged);
  }

  void _onNumberInputChanged(
      NumberInputChanged event, Emitter<PhoneAuthState> emit) async {
    //emit(state.copyWith(status: PhoneAuthStatus.loading));
    try {
      if (event.text.length < 10) {
        emit(state.copyWith(status: PhoneAuthStatus.invalid));
      } else {
        emit(state.copyWith(status: PhoneAuthStatus.valid));
      }
    } catch (error, stacktrace) {
      //print(stacktrace);
      emit(state.copyWith(status: PhoneAuthStatus.error));
    }
  }
}
