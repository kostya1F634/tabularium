import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabularium/l10n/app_localizations.dart';
import '../../../../core/widgets/app_menu_bar.dart';
import '../bloc/welcome_bloc.dart';
import '../bloc/welcome_event.dart';
import '../bloc/welcome_state.dart';
import '../widgets/welcome_content.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WelcomeBloc, WelcomeState>(
      listener: (context, state) {
        if (state is DirectorySelected) {
          // Navigate to main screen
          Navigator.of(
            context,
          ).pushReplacementNamed('/main', arguments: state.path);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.surface,
          leading: const AppMenuBar(),
          leadingWidth: double.infinity,
          toolbarHeight: kToolbarHeight / 2,
          elevation: 1,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.1),
                Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              ],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: BlocBuilder<WelcomeBloc, WelcomeState>(
                    builder: (context, state) {
                      if (state is WelcomeInitial || state is WelcomeLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is WelcomeError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 64,
                                color: Theme.of(context).colorScheme.error,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                AppLocalizations.of(
                                  context,
                                )!.errorMessage(state.message),
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<WelcomeBloc>().add(
                                    const LoadRecentDirectories(),
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.retry,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      if (state is WelcomeLoaded) {
                        return WelcomeContent(
                          recentDirectories: state.recentDirectories,
                          onPickDirectory: () {
                            context.read<WelcomeBloc>().add(
                              const PickDirectory(),
                            );
                          },
                          onSelectDirectory: (path) {
                            context.read<WelcomeBloc>().add(
                              SelectRecentDirectory(path),
                            );
                          },
                        );
                      }

                      if (state is DirectoryPicking) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
