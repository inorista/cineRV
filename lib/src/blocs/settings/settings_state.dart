part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState({required this.themes});
  final ThemeData themes;

  @override
  List<Object> get props => [themes];
}
