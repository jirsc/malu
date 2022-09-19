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
      var testNum = state.user.phoneNumber ?? '+639007771122';
      if (testNum.length < 13) {
        return [Management.page()];
      }
      return [Home.page()];
    case AppStatus.unauthenticated:

    default:
      return [WelcomeScreen.page()];
  }
}
