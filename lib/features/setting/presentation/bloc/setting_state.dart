part of 'setting_bloc.dart';

@immutable
sealed class SettingState {
  final bool isDarkMode;
  const SettingState(this.isDarkMode);
}

final class SettingInitial extends SettingState {
  const SettingInitial() : super(false);
}
final class SettingLoading extends SettingState {
  const SettingLoading(bool isDarkMode) : super(isDarkMode);
}

/// حالت موفق پس از تغییر تم
final class SettingLoaded extends SettingState {
  const SettingLoaded(bool isDarkMode) : super(isDarkMode);
}

/// حالت خطا
final class SettingError extends SettingState {
  final String message;
  const SettingError(this.message, bool isDarkMode) : super(isDarkMode);
}