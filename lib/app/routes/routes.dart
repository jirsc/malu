import 'package:malu/core/core.dart';
import 'package:malu/modules/data_management/management_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:malu/app/app.dart';
import 'package:malu/modules/modules.dart';

List<Page> onGenerateAppViewPages(AppState state, List<Page<dynamic>> pages) {
  switch (state.status) {
    case AppStatus.userEmailUnverified:
    //return [VerifyEmailScreen.page()];
    case AppStatus.authenticated:
    case AppStatus.pinLocked:
      late String testNum;

      if (state.user.phoneNumber == null || state.user.phoneNumber!.isEmpty) {
        testNum = '+639007771122';
      } else {
        testNum = state.user.phoneNumber!;
      }

      if (testNum.length < 13) {
        return [Management.page()];
      } else {
        return [Home.page()];
      }
    case AppStatus.unauthenticated:

    default:
      return [WelcomeScreen.page()];
  }
}
