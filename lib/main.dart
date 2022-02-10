import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:doeat/app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /* SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard'); 
  await prefs.setInt("initScreen", 1);*/

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  BlocOverrides.runZoned(
    () => runApp(App(authenticationRepository: authenticationRepository)),
    blocObserver: AppBlocObserver(),
  );
}
