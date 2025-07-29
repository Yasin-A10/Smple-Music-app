part of 'setting_bloc.dart';

@immutable
sealed class SettingEvent {}

final class ToggleThemeEvent extends SettingEvent {}
