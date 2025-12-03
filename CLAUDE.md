# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Tabularium is a Flutter desktop application for managing PDF book libraries. It implements Clean Architecture with BLoC state management, featuring shelf organization, search, multiple view modes (grid/cabinet), theming, and bilingual support (English/Russian).

## Available MCP Servers

**IMPORTANT**: Always use available MCP servers for enhanced capabilities. These servers provide specialized tools that should be preferred over standard tools.

### Context7 Server
Use for retrieving up-to-date documentation and code examples for any library:

```dart
// Before using any library, look up documentation
mcp__context7__resolve-library-id  // Find library ID
mcp__context7__get-library-docs    // Get documentation
```

**When to use**:
- Learning how to use a new package (flutter_bloc, pdfrx, file_picker, etc.)
- Looking up API references and best practices
- Finding code examples for specific features

### Serena Server
Professional coding agent with semantic tools for intelligent code navigation and editing:

**Key capabilities**:
- `list_dir` - List directory contents
- `find_file` - Find files by pattern
- `get_symbols_overview` - Get high-level view of file structure
- `find_symbol` - Find specific classes, methods, functions by name
- `find_referencing_symbols` - Find all references to a symbol
- `search_for_pattern` - Search code with regex patterns
- `replace_symbol_body` - Replace entire symbol implementation
- `insert_after_symbol` / `insert_before_symbol` - Add code around symbols
- `rename_symbol` - Rename across entire codebase

**When to use Serena tools**:
- **ALWAYS** prefer Serena tools over standard Read/Grep/Glob for code exploration
- Finding class/method definitions without knowing exact file location
- Understanding code architecture and symbol relationships
- Refactoring (renaming, moving code)
- Reading only necessary code instead of entire files (token-efficient)

**Important**: Serena tools are optimized for reading ONLY necessary code. Use `get_symbols_overview` first, then `find_symbol` with `include_body=True` only for specific symbols you need.

**Example workflow**:
```
1. Use find_file to locate relevant files
2. Use get_symbols_overview to see file structure
3. Use find_symbol to read specific methods/classes
4. Use find_referencing_symbols to understand usage
5. Use replace_symbol_body or insert_* to make changes
```

## Token Efficiency Guidelines

**CRITICAL**: Be extremely mindful of token usage. Every read, write, and response consumes tokens from the budget.

### Reading Code
- **NEVER** read entire files unless absolutely necessary
- **ALWAYS** use Serena's `get_symbols_overview` first to understand file structure
- Use `find_symbol` with `include_body=True` ONLY for specific symbols you need
- Use `offset` and `limit` parameters when reading large files
- Prefer targeted searches (Grep with specific patterns) over broad file reads
- When exploring codebase, use Task tool with Explore agent instead of manual searching

### Writing Responses
- Be **concise** - avoid verbose explanations
- Don't repeat information already known from context
- Skip unnecessary pleasantries and filler words
- Use bullet points instead of long paragraphs
- Only show code snippets when necessary, not entire files
- Avoid redundant confirmations like "I'll do X" followed by "Now I'm doing X"

### Working Efficiently
1. **Plan before acting**: Think about what you actually need to know before reading
2. **Read minimally**: Only read the specific symbols/sections relevant to the task
3. **Batch operations**: Make multiple parallel tool calls when possible
4. **Avoid re-reading**: If you already read something, don't read it again
5. **Use memory**: Serena's memory system stores important project info - use it

### Anti-patterns (AVOID)
- ❌ Reading entire files "just to understand the context"
- ❌ Reading the same file multiple times in one conversation
- ❌ Using Read tool when you should use get_symbols_overview
- ❌ Writing long explanatory responses when a short answer suffices
- ❌ Repeating code back to the user that they already have
- ❌ Manual file exploration when Task tool with Explore agent would be better

### Good Practices
- ✅ Read only specific methods/classes with find_symbol
- ✅ Use get_symbols_overview to get file structure (50-100 tokens vs 2000+ for full file)
- ✅ Give brief, direct answers
- ✅ Show only changed code sections, not entire files
- ✅ Use parallel tool calls to save round trips
- ✅ Trust previous context - don't verify unnecessarily

**Remember**: Token efficiency directly impacts how much work can be done in a session. Always ask yourself: "Do I really need to read this?" and "Can I be more concise?"

## Essential Commands

### Development
```bash
make run-linux          # Run on Linux (primary platform)
make run                # Run with platform selection
flutter run -d linux    # Direct Flutter run
```

### Building
```bash
make build              # Release build for Linux
flutter build linux --release
flutter build linux --debug
```

### Testing
```bash
make test               # Run all tests
make test-verbose       # Tests with expanded output
make coverage-html      # Generate and open HTML coverage report
flutter test path/to/specific_test.dart  # Run single test file
```

### Code Quality
```bash
make lint               # Run analyzer (with --no-fatal-infos)
make format             # Format all code
make format-check       # Check formatting without modifying
make check              # Run format-check + lint + test
make pre-commit         # All pre-commit checks
```

### Code Generation
```bash
make gen-mocks          # Generate test mocks (build_runner)
flutter gen-l10n        # Regenerate localization files
```

### Dependency Management
```bash
make deps               # Install dependencies (flutter pub get)
make deps-upgrade       # Update dependencies
make deps-outdated      # Check for outdated packages
```

## Architecture

### Clean Architecture Layers

```
Presentation → BLoC → Domain → Data → External Services
```

**Key principle**: Dependencies flow inward only. Domain layer is framework-agnostic.

### Feature Structure

Each feature (`welcome`, `library`) follows this structure:

```
feature/
├── di/                    # Dependency injection (manual factory pattern)
├── domain/
│   ├── entities/          # Immutable data models (extend Equatable)
│   ├── repositories/      # Repository interfaces
│   └── usecases/          # Business logic use cases
├── data/
│   ├── datasources/       # Concrete data sources
│   └── repositories/      # Repository implementations
└── presentation/
    ├── bloc/              # BLoC (events, states, bloc)
    ├── pages/             # Full-screen pages
    └── widgets/           # Feature-specific widgets
```

### State Management

**BLoC Pattern** (flutter_bloc):
- **Events**: User actions (`SelectShelf`, `AddBookToShelf`, etc.)
- **States**: UI representations (`LibraryLoaded`, `LibraryLoading`, etc.)
- **BLoC**: Event handlers that emit states

**Global State** (ChangeNotifier services):
- `ThemeService` - 24+ themes
- `LanguageService` - English/Russian
- `UISettingsService` - Font size, book scale
- `WindowSettingsService` - Window state

### Data Persistence

**App Settings** (global):
- Location: `~/.config/tabularium/settings.json` (Linux)
- Implementation: `lib/core/services/settings_storage.dart`
- Custom JSON-based storage (not SharedPreferences)

**Library Configuration** (per-library):
- Location: `.tabularium.conf` in library root directory
- Contains: books, shelves, metadata
- Thumbnails: `.thumbnails/` subdirectory

### Key Entities

**Book**: id, fileName, filePath, title, author, alias, thumbnailPath, dates, pageCount, fileSize

**Shelf**: id, name, bookIds (list of IDs, not Book objects), isDefault, createdDate

**LibraryConfig**: directoryPath, books[], shelves[], lastScanDate, lastSelectedShelfId

## Important Patterns

### Immutability
All entities are immutable with `copyWith()` methods. Never mutate entities directly.

### Value Equality
Events and states extend Equatable for proper equality checks and efficient rebuilds.

### Manual Dependency Injection
Dependencies created explicitly in `*Dependencies` classes (no get_it/service_locator). Transparent and testable.

### BLoC Event Flow
```
UI emits event → BLoC handler → Use case → Repository → Data source
                        ↓
                  Emit new state → UI rebuilds
```

### Auto-Save Pattern
Every state change triggers `SaveLibraryUseCase` to persist configuration immediately.

## Localization

**Files**:
- `lib/l10n/app_en.arb` - English translations
- `lib/l10n/app_ru.arb` - Russian translations

**After editing ARB files**:
```bash
flutter gen-l10n
```

**Usage**:
```dart
final l10n = AppLocalizations.of(context)!;
Text(l10n.welcomeTitle);
```

## Testing

### Structure
Tests mirror `lib/` structure:
```
test/
├── core/services/
├── features/
│   ├── welcome/
│   │   ├── domain/entities/
│   │   ├── domain/usecases/
│   │   ├── data/repositories/
│   │   └── presentation/bloc/
│   └── library/
```

### Mocking
Use Mockito with code generation:
```dart
@GenerateMocks([GetRecentDirectories, DirectoryRepository])
void main() {
  late MockGetRecentDirectories mockUseCase;
  // ...
}
```

After adding `@GenerateMocks`:
```bash
make gen-mocks
```

### BLoC Testing
Use `bloc_test` package:
```dart
blocTest<WelcomeBloc, WelcomeState>(
  'emits [WelcomeLoading, WelcomeLoaded] when LoadRecentDirectories is added',
  build: () => WelcomeBloc(/*...*/),
  act: (bloc) => bloc.add(const LoadRecentDirectories()),
  expect: () => [
    const WelcomeLoading(),
    WelcomeLoaded(/*...*/),
  ],
);
```

## Common Development Workflows

### Adding a New Feature Event
1. Add event class to `*_event.dart` (extend Equatable)
2. Add event handler method in BLoC: `on<EventName>(_onEventName)`
3. Implement handler to emit appropriate states
4. Update UI to dispatch event: `context.read<FeatureBloc>().add(EventName())`

### Adding a New Use Case
1. Create use case in `domain/usecases/`
2. Define call method with clear input/output
3. Use repository interface (not implementation)
4. Inject repository via constructor
5. Add to DI container in `di/*_dependencies.dart`

### Adding a Translation
1. Edit `lib/l10n/app_en.arb` and `lib/l10n/app_ru.arb`
2. Run `flutter gen-l10n`
3. Use in code: `AppLocalizations.of(context)!.yourKey`

### Adding a New Theme
1. Add theme definition in `lib/core/theme/app_theme.dart`
2. Add to `AppThemeMode` enum
3. Add to theme map in `ThemeService`
4. Theme persists automatically via settings service

## Project-Specific Notes

### Library Initialization Flow
```
1. User selects directory (Welcome screen)
2. Navigate to Main screen with path
3. LibraryBloc.InitializeLibrary event
4. Scan directory for PDFs
5. Load or create .tabularium.conf
6. Generate thumbnails (progress callbacks)
7. Save config
8. Emit LibraryLoaded state
```

### Shelf System
- **"All Books"**: Default shelf showing entire collection
- **"Unsorted"**: Books not in any custom shelf
- **Custom Shelves**: User-created shelves
- Shelves store book IDs only (not full Book objects)
- Books can be in multiple shelves

### View Modes
- **Grid View**: Classic thumbnail grid
- **Cabinet View**: 3D bookshelf visualization
- Independent scale settings for each view

### Window Management
Desktop-specific window state (size, position, maximized) managed by `WindowSettingsService` using `window_manager` package.

## Development Environment

**Flutter SDK**: 3.27.1 or higher
**Dart SDK**: 3.6.0 or higher (included with Flutter)

**Linux Dependencies**:
```bash
# Arch/Manjaro
sudo pacman -S clang cmake ninja pkgconf gtk3 xz

# Ubuntu/Debian
sudo apt install clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
```

## Critical Files

- `lib/main.dart` - App entry point, service initialization, route setup
- `lib/core/routes/app_routes.dart` - Route generation with DI setup
- `lib/features/library/presentation/bloc/library_bloc.dart` - Main app logic (1000+ lines)
- `lib/core/services/settings_storage.dart` - Cross-platform settings persistence
- `lib/features/library/domain/entities/library_config.dart` - Core data model

## Code Analysis

The project uses `flutter analyze --no-fatal-infos` which suppresses info-level warnings. This is intentional for CI/CD and should be preserved in commands.

## Git Workflow

Current branch: `main`
All features developed directly on main (no separate develop branch).

## Known Constraints

- Primary platform: Linux (tested on Manjaro, Ubuntu)
- Windows/macOS support exists but not primary focus
- Large PDF files (>100MB) may have slow thumbnail generation
- Cabinet view performance degrades with 1000+ books
