import 'package:bloc/bloc.dart';
import 'package:cinerv/src/blocs/settings/app_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState(themes: appThemeData[AppTheme.NormalTheme]!)) {
    on<ChangeThemeMode>((event, emit) {
      if (event.isDarkMode == true) {
        emit(SettingsState(themes: appThemeData[AppTheme.DarkTheme]!));
      } else if (event.isDarkMode == false) {
        emit(SettingsState(themes: appThemeData[AppTheme.NormalTheme]!));
      }
    });
  }
}
