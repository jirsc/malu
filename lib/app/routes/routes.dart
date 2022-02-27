import 'package:doeat/app/views/welcome_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:doeat/app/app.dart';
import 'package:doeat/modules/modules.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [Home.page()];
    case AppStatus.unauthenticated:

    default:
      return [WelcomeScreen.page()];
  }
}
