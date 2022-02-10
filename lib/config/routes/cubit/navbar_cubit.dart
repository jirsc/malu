import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:doeat/constants/app_constants.dart';

part 'navbar_state.dart';

class NavbarCubit extends Cubit<NavbarState> {
  NavbarCubit() : super(const NavbarState(NavbarItem.home, 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.home:
        emit(const NavbarState(NavbarItem.home, 0));
        break;
      case NavbarItem.activity:
        emit(const NavbarState(NavbarItem.activity, 1));
        break;
      case NavbarItem.account:
        emit(const NavbarState(NavbarItem.account, 2));
        break;
    }
  }
}
