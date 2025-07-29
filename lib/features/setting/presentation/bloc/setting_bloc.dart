import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitial()) {
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  Future<void> _onToggleTheme(
    ToggleThemeEvent event,
    Emitter<SettingState> emit,
  ) async {
    final currentMode = state.isDarkMode;
    // ابتدا حالت لودینگ برای حفظ UI
    emit(SettingLoading(currentMode));
    try {
      final newMode = !currentMode;
      // شبیه‌سازی تأخیر
      await Future.delayed(const Duration(milliseconds: 200));
      emit(SettingLoaded(newMode));
    } catch (e) {
      emit(SettingError(e.toString(), currentMode));
    }
  }
}