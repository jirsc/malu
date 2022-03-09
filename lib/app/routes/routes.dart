import 'package:doeat/core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:doeat/app/app.dart';
import 'package:doeat/modules/modules.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.userEmailUnverified:
    //return [VerifyEmailScreen.page()];
    case AppStatus.authenticated:
    case AppStatus.pinLocked:
      return [Home.page()];
    case AppStatus.unauthenticated:

    default:
      return [WelcomeScreen.page()];
  }
}
