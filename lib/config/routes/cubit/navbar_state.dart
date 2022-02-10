part of 'navbar_cubit.dart';

class NavbarState extends Equatable {
  final NavbarItem navbarItem;
  final int index;

  const NavbarState(this.navbarItem, this.index);

  @override
  List<Object> get props => [navbarItem, index];
}
