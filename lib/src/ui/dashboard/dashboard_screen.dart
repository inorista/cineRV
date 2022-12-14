import 'package:cinerv/src/blocs/bottom_navigator/bottom_navigator_bloc.dart';
import 'package:cinerv/src/blocs/settings/settings_bloc.dart';
import 'package:cinerv/src/ui/discover/discover_screen.dart';
import 'package:cinerv/src/ui/home/home_screen.dart';
import 'package:cinerv/src/ui/lovelist/lovelist_screen.dart';
import 'package:cinerv/src/ui/settings/settings_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigatorBloc, BottomNavigatorState>(
      buildWhen: (previous, current) {
        return previous != current;
      },
      builder: (context, state) {
        return Scaffold(
          primary: false,
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body: IndexedStack(
            index: state.index,
            children: const <Widget>[
              HomeScreen(),
              DiscoverScreen(),
              LoveListScreen(),
              SettingsScreen(),
            ],
          ),
          bottomNavigationBar: SizedBox(
            height: 82,
            child: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, settingsState) {
                return Theme(
                  data: ThemeData(
                    bottomNavigationBarTheme: settingsState.themes.bottomNavigationBarTheme,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: BottomNavigationBar(
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    elevation: 0,
                    type: BottomNavigationBarType.fixed,
                    iconSize: 25,
                    selectedFontSize: 10,
                    unselectedFontSize: 10,
                    onTap: (index) {
                      context.read<BottomNavigatorBloc>().add(ChangeIndexEvent(index: index));
                    },
                    currentIndex: state.index,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Iconsax.home5),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(EvaIcons.grid),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Iconsax.heart5),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(EvaIcons.settings2),
                        label: "",
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
