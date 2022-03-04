import 'package:flutter/material.dart';

enum NavbarItem { home, activity, account }

const Color grayColor = Color(0xFF8D8D8E);

const double defaultPadding = 12.0;

enum EntryType { login, signUp }

extension EntryTypeX on EntryType {
  bool get isLogin => this == EntryType.login;
  bool get isSignUp => this == EntryType.signUp;
}
