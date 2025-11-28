import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/app_settings.dart';

import '../../../../core/services/view_mode_service.dart';
import '../../di/library_dependencies.dart';
import '../bloc/library_event.dart';
import 'library_screen.dart';
import 'cabinet_screen.dart';

enum LibraryViewMode { grid, cabinet }

/// Wrapper that manages switching between grid and cabinet views
class LibraryViewWrapper extends StatefulWidget {
  final String directoryPath;

  const LibraryViewWrapper({super.key, required this.directoryPath});

  @override
  State<LibraryViewWrapper> createState() => _LibraryViewWrapperState();
}

class _LibraryViewWrapperState extends State<LibraryViewWrapper> {
  LibraryViewMode _viewMode = LibraryViewMode.grid;
  ViewModeService? _viewModeService;

  @override
  void initState() {
    super.initState();
    _loadViewMode();
  }

  Future<void> _loadViewMode() async {
    final prefs = await AppSettings.getInstance();
    _viewModeService = ViewModeService(prefs);

    if (mounted) {
      setState(() {
        _viewMode = _viewModeService!.getViewMode();
      });
    }
  }

  void _toggleViewMode() {
    setState(() {
      _viewMode = _viewMode == LibraryViewMode.grid
          ? LibraryViewMode.cabinet
          : LibraryViewMode.grid;
    });

    // Save the new view mode
    _viewModeService?.setViewMode(_viewMode);
  }

  @override
  Widget build(BuildContext context) {
    // Wrap both screens with BLoC provider
    final screen = _viewMode == LibraryViewMode.grid
        ? LibraryScreen(directoryPath: widget.directoryPath)
        : BlocProvider(
            create: (_) =>
                LibraryDependencies().createLibraryBloc()
                  ..add(InitializeLibrary(widget.directoryPath)),
            child: const CabinetScreen(),
          );

    return ViewModeProviderWidget(
      viewMode: _viewMode,
      onToggle: _toggleViewMode,
      child: screen,
    );
  }
}

/// Widget to provide view mode state to descendant widgets
/// Made public so it can be accessed from app_menu_bar.dart
class ViewModeProviderWidget extends StatelessWidget {
  final LibraryViewMode viewMode;
  final VoidCallback onToggle;
  final Widget child;

  const ViewModeProviderWidget({
    super.key,
    required this.viewMode,
    required this.onToggle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
