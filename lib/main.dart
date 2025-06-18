import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/theme/theme_bloc.dart';
import 'blocs/github/github_bloc.dart';
import 'services/preferences_service.dart';
import 'ui/screens/home_screen.dart';
import 'services/github_service.dart';
import 'blocs/github/github_event.dart';
import 'blocs/theme/theme_event.dart';
import 'blocs/theme/theme_state.dart';
import 'ui/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferencesService = PreferencesService();
  await preferencesService.init();

  runApp(MyApp(preferencesService: preferencesService));
}

class MyApp extends StatelessWidget {
  final PreferencesService preferencesService;

  const MyApp({required this.preferencesService, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => ThemeBloc(preferencesService)..add(LoadThemeEvent()),
        ),
        BlocProvider(
          create:
              (context) =>
                  GithubBloc(GithubService())
                    ..add(FetchGithubReposEvent('Yordanos-Samson')),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'PortfolioSync',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const HomeScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
