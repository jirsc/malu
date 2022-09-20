import 'package:malu/utils/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malu/modules/modules.dart';
import 'package:malu/config/config.dart';
import 'package:malu/constants/app_constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static Page page() => const MaterialPage(child: Home());

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //print('nakalogin na');
    //final textTheme = Theme.of(context).textTheme;
    //final user = context.select((AppBloc bloc) => bloc.state.user);
    return BlocProvider<NavbarCubit>(
      create: (context) => NavbarCubit(),
      child: Scaffold(
        body: BlocBuilder<NavbarCubit, NavbarState>(builder: (context, state) {
          if (state.navbarItem == NavbarItem.home) {
            return ExploreScreen();
          } else if (state.navbarItem == NavbarItem.activity) {
            return ExploreScreen();
          } else if (state.navbarItem == NavbarItem.plan) {
            return AccountScreen();
          } else if (state.navbarItem == NavbarItem.account) {
            return const AccountScreen();
          }
          return Container();
        }),
        bottomNavigationBar: BlocBuilder<NavbarCubit, NavbarState>(
          builder: (context, state) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: theme.primaryColor,
              currentIndex: state.index,
              onTap: (index) {
                if (index == 0) {
                  BlocProvider.of<NavbarCubit>(context)
                      .getNavBarItem(NavbarItem.home);
                } else if (index == 1) {
                  BlocProvider.of<NavbarCubit>(context)
                      .getNavBarItem(NavbarItem.activity);
                } else if (index == 2) {
                  BlocProvider.of<NavbarCubit>(context)
                      .getNavBarItem(NavbarItem.plan);
                } else if (index == 3) {
                  BlocProvider.of<NavbarCubit>(context)
                      .getNavBarItem(NavbarItem.account);
                }
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesome4.doc_text),
                  label: 'Activity',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesome4.edit),
                  label: 'Plan',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Account',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
