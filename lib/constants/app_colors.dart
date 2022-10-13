import 'package:flutter/material.dart';

//Todo:
/* 
For accessing the static variable cleaner, try to create another class then access each static variable from the class.
Example:
Class AppColor {
  AppLink appLink = AppLink();
}

Class AppLink extends AppColor {
  static Color? textColor = *Your color here..*;
  .. *other static colors here..*
}

So that if it was called from the class/file/page you are working on, it should be just:
AppColor.appLink.textColor;

Still doing RnD for this method..
For now, please add the colors the app will be using here so that it can be only adjusted here.
*/

class AppColor {
  static Color? appLinkTextColor = Colors.blue[600];
  static Color? appLinkBorderColor = Colors.blue[300];
}
