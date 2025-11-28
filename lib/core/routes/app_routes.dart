import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/services/app_settings.dart';
import '../../features/library/presentation/pages/library_view_wrapper.dart';
import '../../features/welcome/di/welcome_dependencies.dart';
import '../../features/welcome/presentation/bloc/welcome_event.dart';
import '../../features/welcome/presentation/pages/welcome_screen.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String main = '/main';

  static Route<dynamic> generateRoute(
    RouteSettings settings,
    AppSettings prefs,
  ) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(
          builder: (_) {
            final repository = WelcomeDependencies.createDirectoryRepository(
              prefs,
            );
            final bloc = WelcomeDependencies.createWelcomeBloc(repository);

            // Загружаем недавние директории при создании экрана
            bloc.add(const LoadRecentDirectories());

            return BlocProvider.value(
              value: bloc,
              child: const WelcomeScreen(),
            );
          },
        );

      case main:
        if (settings.arguments == null) {
          // This shouldn't happen, but just in case
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(child: Text('Error: No directory path provided')),
            ),
          );
        }
        final path = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LibraryViewWrapper(directoryPath: path),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
