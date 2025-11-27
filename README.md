# Tabularium

Cross-platform book organization application built with Flutter.

## Supported Platforms

- Linux
- Windows
- macOS
- Web (with file system limitations)

## Project Structure

The project follows a modular, feature-based architecture:

```
lib/
├── core/                      # Application core
│   ├── routes/               # Navigation and routing
│   ├── theme/                # Application themes
│   └── constants/            # Constants
├── features/                  # Feature modules
│   ├── welcome/              # Welcome module
│   │   ├── data/             # Data layer (repositories)
│   │   ├── domain/           # Business logic (entities, use cases)
│   │   ├── presentation/     # UI (screens, widgets, BLoC)
│   │   └── di/               # Dependency Injection
│   └── library/              # Library module
│       ├── data/
│       ├── domain/
│       └── presentation/
├── shared/                    # Shared components
│   ├── widgets/              # Reusable widgets
│   └── services/             # Common services
└── main.dart                  # Entry point

test/                          # Tests (mirrors lib/ structure)
└── features/
    └── welcome/
        ├── data/
        ├── domain/
        └── presentation/
```

## Architecture Principles

### Clean Architecture

The project follows Clean Architecture principles with layer separation:

- **Presentation Layer**: UI, widgets, BLoC (state management)
- **Domain Layer**: Business logic, use cases, entities
- **Data Layer**: Repositories, data sources

### State Management

Uses **BLoC (Business Logic Component)** for state management.

### Dependency Injection

Each module has its own DI container for dependency configuration.

## Commands

The project uses a Makefile for convenience:

### Running the Application

```bash
make run         # Platform selection on startup
make run-linux   # Run on Linux
make run-web     # Run in browser
```

### Testing

```bash
make test        # Run all tests
make coverage    # Run tests with coverage and generate HTML report
```

After running `make coverage`, the report will be available at `coverage/html/index.html`.

### Code Generation

```bash
make gen-mocks   # Generate mocks for tests
```

### Code Quality

```bash
make format      # Format code
make lint        # Run linter
```

### Building

```bash
make build       # Build release version
make clean       # Clean build artifacts
```

### Dependencies

```bash
make deps                # Install dependencies
make deps-upgrade        # Update dependencies
make deps-outdated       # Show outdated dependencies
```

### Help

```bash
make help        # Show all available commands
```

## Testing

The project is covered with unit tests:

- **Entities**: Tests for domain models
- **Use Cases**: Business logic tests
- **Repositories**: Data layer tests
- **BLoC**: State management tests

To run tests with coverage report:

```bash
make coverage
```

Coverage metrics are generated using `lcov` and available as an HTML report.

## Localization

The app supports multiple languages:
- **English** (default)
- **Russian**

Language is automatically saved and persists between app restarts. See [LOCALIZATION.md](docs/LOCALIZATION.md) for detailed i18n documentation.

**Quick example:**
```dart
// Access translations
final l10n = AppLocalizations.of(context)!;
Text(l10n.appTitle);

// Change language
final languageService = LanguageProvider.of(context);
await languageService.changeLanguage(const Locale('ru'));
```

## Features

### Library Management

- **PDF Scanning**: Automatically scans directories for PDF files
- **Thumbnail Generation**: Creates thumbnails from first pages of PDFs
- **Shelf Organization**: Organize books into custom shelves
  - Default "All Books" shelf with all found books
  - Create and delete custom shelves
  - Add/remove books to/from shelves
- **Search**: Quick search across book titles, authors, and filenames
- **Book Opening**: Open books with system default PDF viewer
- **Persistent Configuration**: All settings stored in `.tabularium.conf` JSON file
- **Automatic Rescan**: Scan for newly added books

### Configuration Files

When you select a directory, Tabularium creates:
- `.tabularium.conf` - JSON configuration with library metadata
- `.thumbnails/` - Directory with book cover thumbnails

## Dependencies

### Main

- `flutter_bloc` - State management
- `equatable` - Value equality
- `file_picker` - File and directory selection
- `shared_preferences` - Settings storage
- `flutter_localizations` - Localization support
- `intl` - Internationalization utilities
- `pdfx` - PDF rendering and processing
- `path` - Path manipulation
- `crypto` - Hashing for unique IDs
- `open_filex` - Opening files with system apps

### Dev Dependencies

- `mockito` - Test mocks
- `bloc_test` - BLoC testing
- `build_runner` - Code generation

## Getting Started

1. Install Flutter SDK
2. Clone the repository
3. Install dependencies:
   ```bash
   make deps
   ```
4. Run the application:
   ```bash
   make run-linux
   ```

## Development

When adding new tests with mocks:

1. Add the annotation `@GenerateMocks([ClassName])`
2. Run generation:
   ```bash
   make gen-mocks
   ```

## License

Private project
