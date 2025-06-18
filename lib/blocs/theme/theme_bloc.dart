import 'package:bloc/bloc.dart';
import 'package:portfolio_sync/services/preferences_service.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final PreferencesService preferencesService;

  ThemeBloc(this.preferencesService) : super(ThemeState(false)) {
    on<LoadThemeEvent>((event, emit) {
      final isDarkMode = preferencesService.getThemePreference();
      emit(ThemeState(isDarkMode));
    });

    on<ToggleThemeEvent>((event, emit) async {
      final newTheme = !state.isDarkMode;
      await preferencesService.setThemePreference(newTheme);
      emit(ThemeState(newTheme));
    });
  }
}