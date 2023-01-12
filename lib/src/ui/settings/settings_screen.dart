import 'package:cinerv/src/blocs/settings/app_theme.dart';
import 'package:cinerv/src/blocs/settings/settings_bloc.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        title: const Text("Cài Đặt"),
        leading: GestureDetector(
          onTap: () async {
            Navigator.pop(context);
          },
          child: const Icon(
            EvaIcons.arrowIosBack,
            size: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return CustomScrollView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Dark Mode"),
                      CupertinoSwitch(
                        value: state.themes == appThemeData[AppTheme.NormalTheme] ? false : true,
                        onChanged: (bool value) {
                          context.read<SettingsBloc>().add(ChangeThemeMode(isDarkMode: value));
                        },
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Dark Mode"),
                      Switch(
                        value: state.themes == appThemeData[AppTheme.NormalTheme] ? false : true,
                        onChanged: (bool value) {
                          context.read<SettingsBloc>().add(ChangeThemeMode(isDarkMode: value));
                        },
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Dark Mode"),
                      CupertinoSwitch(
                        value: state.themes == appThemeData[AppTheme.NormalTheme] ? false : true,
                        onChanged: (bool value) {
                          context.read<SettingsBloc>().add(ChangeThemeMode(isDarkMode: value));
                        },
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverToBoxAdapter(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Dark Mode"),
                    SizedBox(height: 100, width: 100, child: RiveSwitch()),
                  ],
                )),
              ],
            );
          },
        ),
      ),
    );
  }
}

class RiveSwitch extends StatefulWidget {
  const RiveSwitch({super.key});

  @override
  State<RiveSwitch> createState() => _RiveSwitchState();
}

class _RiveSwitchState extends State<RiveSwitch> {
  late String animationURL;
  Artboard? riveSwitch;
  SMIBool? isDark;
  StateMachineController? stateMachineController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationURL = defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS
        ? 'assets/images/switch (1).riv'
        : 'images/switch (1).riv';
    rootBundle.load(animationURL).then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        stateMachineController = StateMachineController.fromArtboard(artboard, "State Machine 1");
        if (stateMachineController != null) {
          artboard.addController(stateMachineController!);

          for (var e in stateMachineController!.inputs) {
            debugPrint(e.runtimeType.toString());
            debugPrint("name${e.name}End");
          }

          for (var element in stateMachineController!.inputs) {
            if (element.name == "isDark") {
              isDark = element as SMIBool;
            }
          }
        }

        setState(() {
          isDark?.change(true);
          riveSwitch = artboard;
        });
      },
    );
  }

  void changeState(bool value) {
    isDark?.change(value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state.themes == appThemeData[AppTheme.NormalTheme]!) {
          return GestureDetector(
            onTap: () {
              changeState(false);
              context.read<SettingsBloc>().add(ChangeThemeMode(isDarkMode: true));
            },
            child: Rive(
              artboard: riveSwitch!,
              fit: BoxFit.fitWidth,
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              changeState(true);
              context.read<SettingsBloc>().add(ChangeThemeMode(isDarkMode: false));
            },
            child: Rive(
              artboard: riveSwitch!,
              fit: BoxFit.fitWidth,
            ),
          );
        }
      },
    );
  }
}
