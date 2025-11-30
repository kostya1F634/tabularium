# Tabularium

<p align="center">
  <img src="docs/images/logo.png" alt="Tabularium Logo" width="200"/>
  <!-- TODO: Add application logo -->
</p>

<p align="center">
  <strong>Your Personal Library Manager</strong>
</p>

<p align="center">
  A modern, elegant desktop application for managing your PDF book collection with style and efficiency.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.27.1-02569B?logo=flutter" alt="Flutter Version"/>
  <img src="https://img.shields.io/badge/Platform-Linux-FCC624?logo=linux&logoColor=black" alt="Platform"/>
  <img src="https://img.shields.io/badge/License-MIT-green" alt="License"/>
</p>

---

## 📖 Overview

Tabularium is a powerful desktop application designed to help you organize, browse, and manage your personal PDF book library. Built with Flutter, it provides a beautiful and intuitive interface for categorizing books into custom shelves, searching your collection, and quickly accessing your reading materials.

### Why Tabularium?

- **Local-First**: All your data stays on your machine - no cloud dependencies
- **Shelf Organization**: Create custom shelves to organize books by topic, author, or any category you choose
- **Visual Library**: Browse your collection with automatically generated book cover thumbnails
- **Fast Search**: Quickly find books by title, author, or filename
- **Drag & Drop**: Easily move books between shelves with intuitive drag-and-drop
- **Multiple Views**: Switch between grid and cabinet views to suit your preference
- **Multilingual**: Full support for English and Russian languages
- **Theme Customization**: Choose from 15+ beautiful color themes
- **Keyboard Shortcuts**: Power user features for efficient navigation

<p align="center">
  <img src="docs/images/screenshot-main.png" alt="Main Screen" width="800"/>
  <!-- TODO: Add screenshot of main library view with books grid -->
</p>

---

## ✨ Features

### 📚 Library Management

- **Automatic Book Discovery**: Point Tabularium to your books directory and it automatically scans and indexes all PDF files
- **Metadata Extraction**: Extracts title, author, and page count from PDF metadata
- **Custom Aliases**: Set custom display names for books
- **Thumbnail Generation**: Automatically generates cover thumbnails from the first page of each PDF
- **Book Properties**: View and edit detailed information about each book

<p align="center">
  <img src="docs/images/screenshot-properties.png" alt="Book Properties Dialog" width="600"/>
  <!-- TODO: Add screenshot of book properties dialog -->
</p>

### 🗂️ Shelf Organization

- **Custom Shelves**: Create unlimited custom shelves to organize your collection
- **Smart Default Shelves**:
  - **All Books**: View your entire collection
  - **Unsorted**: Books not yet added to any custom shelf
- **Drag & Drop**: Move books between shelves by dragging them onto shelf names
- **Shelf Search**: Quickly filter through your shelves when you have many
- **Reorderable**: Arrange shelves in any order you prefer
- **Multi-Book Operations**: Add multiple books to a shelf at once

<p align="center">
  <img src="docs/images/screenshot-shelves.png" alt="Shelves Sidebar" width="300"/>
  <!-- TODO: Add screenshot of shelves sidebar -->
</p>

### 🔍 Search & Filter

- **Real-time Search**: Search across book titles, authors, and filenames as you type
- **Shelf Filtering**: Filter books within specific shelves
- **Quick Clear**: Easily clear search results with one click
- **Search Persistence**: Search remains active as you navigate between shelves

### 🎨 View Modes

- **Grid View**: Classic grid layout with book covers and titles
- **Cabinet View**: 3D bookshelf visualization for a more realistic library feel
- **Adjustable Scale**: Customize book size in both views to fit your screen and preferences

<p align="center">
  <img src="docs/images/screenshot-cabinet.png" alt="Cabinet View" width="800"/>
  <!-- TODO: Add screenshot of cabinet/bookshelf view -->
</p>

### 🎯 Selection & Batch Operations

- **Multi-Select**: Select multiple books for batch operations
- **Select All**: Quickly select all books in current view
- **Batch Open**: Open multiple books simultaneously
- **Batch Add to Shelf**: Add multiple selected books to a shelf at once
- **Batch Delete**: Remove multiple books from shelves or permanently delete files

### ⚙️ Customization

- **15+ Themes**: Choose from a wide variety of color schemes including:
  - Default Blue, Indigo Night, Purple Dream
  - Green Forest, Teal Ocean, Orange Sunset
  - Pink Blossom, Red Passion, Brown Earth
  - Deep Purple, Amber Glow, Lime Fresh
  - Cyan Wave, Blue Grey, Deep Orange
- **Font Size Adjustment**: Scale UI text to your preference
- **Book Scale Controls**: Separate scale settings for grid and cabinet views
- **Language Selection**: Full English and Russian interface translations
- **Settings Persistence**: All preferences saved automatically

<p align="center">
  <img src="docs/images/screenshot-themes.png" alt="Theme Selection" width="600"/>
  <!-- TODO: Add screenshot showing different theme options -->
</p>

### ⌨️ Keyboard Shortcuts

Power users will appreciate the extensive keyboard shortcut support:

- **Navigation & Search**:
  - `Ctrl+F` - Focus search field
  - `Esc` - Clear search
  - `Ctrl+1` through `Ctrl+0` - Select shelves 1-10
  - `F1` - Show keyboard shortcuts help

- **Selection**:
  - `Ctrl+A` - Select all books
  - `Ctrl+D` - Clear selection
  - `Delete` - Remove selected books from shelf

- **Views & Display**:
  - `Ctrl+G` - Switch to grid view
  - `Ctrl+B` - Switch to cabinet view
  - `Ctrl++` / `Ctrl+-` - Adjust book scale
  - `Ctrl+0` - Reset book scale

- **Application**:
  - `F5` - Scan for new books
  - `Ctrl+,` - Open settings
  - `Ctrl+Q` - Quit application

---

## 🖥️ System Requirements

### Runtime Requirements

- **Operating System**: Linux (tested on Manjaro, Ubuntu 20.04+)
- **Display**: Minimum 1280x720 resolution recommended
- **RAM**: 2GB minimum, 4GB recommended for large libraries
- **Storage**: ~50MB for application + space for book thumbnails
- **PDF Viewer**: Default system PDF viewer for opening books

### Build Requirements

To build Tabularium from source, you'll need:

- **Flutter SDK**: Version 3.27.1 or higher
- **Dart SDK**: Version 3.6.0 or higher (included with Flutter)
- **Linux Development Tools**:
  - `clang`
  - `cmake` (3.10 or higher)
  - `ninja-build`
  - `pkg-config`
  - `libgtk-3-dev`
  - `liblzma-dev`
  - `libstdc++-12-dev`

---

## 🚀 Building from Source

### 1. Install Flutter

If you haven't already installed Flutter, follow the official guide:

```bash
# Download Flutter
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Verify installation
flutter doctor
```

For detailed instructions, visit: https://docs.flutter.dev/get-started/install/linux

### 2. Install Linux Development Dependencies

#### Ubuntu/Debian:
```bash
sudo apt-get update
sudo apt-get install -y \
  clang \
  cmake \
  ninja-build \
  pkg-config \
  libgtk-3-dev \
  liblzma-dev \
  libstdc++-12-dev
```

#### Fedora/RHEL:
```bash
sudo dnf install -y \
  clang \
  cmake \
  ninja-build \
  pkgconfig \
  gtk3-devel \
  xz-devel
```

#### Arch/Manjaro:
```bash
sudo pacman -S \
  clang \
  cmake \
  ninja \
  pkgconf \
  gtk3 \
  xz
```

### 3. Clone the Repository

```bash
git clone https://github.com/yourusername/tabularium.git
cd tabularium
```

### 4. Install Dependencies

```bash
# Get Flutter packages
flutter pub get

# Generate localization files
flutter gen-l10n
```

### 5. Build the Application

#### Debug Build (for development):
```bash
flutter build linux --debug
```

The debug build will be located at: `build/linux/x64/debug/bundle/`

#### Release Build (for production):
```bash
flutter build linux --release
```

The release build will be located at: `build/linux/x64/release/bundle/`

### 6. Run the Application

#### From Source:
```bash
flutter run -d linux
```

#### From Build:
```bash
# Debug build
./build/linux/x64/debug/bundle/tabularium

# Release build
./build/linux/x64/release/bundle/tabularium
```

---

## 📦 Installation

### From Release Build

1. Download the latest release from the releases page
2. Extract the archive:
   ```bash
   tar -xzf tabularium-linux-x64.tar.gz
   ```
3. Run the application:
   ```bash
   cd tabularium
   ./tabularium
   ```

### Create Desktop Entry (Optional)

To add Tabularium to your application menu:

```bash
# Create desktop entry
cat > ~/.local/share/applications/tabularium.desktop <<EOF
[Desktop Entry]
Name=Tabularium
Comment=Your Personal Library Manager
Exec=/path/to/tabularium/tabularium
Icon=/path/to/tabularium/data/flutter_assets/assets/icon.png
Terminal=false
Type=Application
Categories=Office;Viewer;
EOF

# Update desktop database
update-desktop-database ~/.local/share/applications/
```

---

## 🎯 Usage

### First Launch

1. **Welcome Screen**: On first launch, you'll see the welcome screen
2. **Select Directory**: Click "Select Books Directory" and choose the folder containing your PDF books
3. **Initialization**: Tabularium will scan the directory and create thumbnails (this may take a few minutes for large collections)
4. **Start Organizing**: Your library is ready! Start creating shelves and organizing your books

<p align="center">
  <img src="docs/images/screenshot-welcome.png" alt="Welcome Screen" width="700"/>
  <!-- TODO: Add screenshot of welcome screen -->
</p>

### Quick Start Guide

1. **Create a Shelf**: Click "Create Shelf" in the sidebar and name it
2. **Add Books to Shelf**:
   - Drag books from the main view onto a shelf name
   - Or right-click a book → "Add" → select shelf
3. **Select Multiple Books**: Click books while holding Ctrl to select multiple
4. **Search Books**: Use the search field in the top-right to find specific books
5. **Open Books**: Double-click a book or select and press Enter
6. **Change View**: Click the view toggle button in the toolbar to switch between grid and cabinet views

### Directory Management

- **Recent Directories**: Your recently opened directories are saved for quick access
- **Favorites**: Star directories to keep them in your favorites list
- **Switch Directories**: Click the home icon to return to the welcome screen and select a different directory

---

## 🏗️ Project Structure

```
tabularium/
├── lib/
│   ├── core/                    # Core functionality
│   │   ├── services/           # Services (settings, UI)
│   │   ├── theme/              # Theme definitions
│   │   └── widgets/            # Shared widgets (menu bar, dialogs)
│   ├── features/
│   │   ├── library/            # Main library feature
│   │   │   ├── data/           # Data sources & repositories
│   │   │   ├── domain/         # Entities & use cases
│   │   │   └── presentation/   # UI (pages, widgets, BLoC)
│   │   └── welcome/            # Welcome screen feature
│   │       ├── data/
│   │       ├── domain/
│   │       └── presentation/
│   ├── l10n/                   # Localization files
│   └── main.dart               # Application entry point
├── linux/                      # Linux platform specific code
├── test/                       # Unit and widget tests
├── assets/                     # Images and other assets
└── docs/                       # Documentation and images
```

---

## 🧪 Testing

### Run All Tests

```bash
flutter test
```

### Run Tests with Coverage

```bash
# Using Make
make coverage

# Or manually
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
xdg-open coverage/html/index.html
```

### Run Code Analysis

```bash
flutter analyze
```

---

## 🛠️ Development

### Code Style

This project follows the official [Dart style guide](https://dart.dev/guides/language/effective-dart/style).

### Run in Development Mode

```bash
# Hot reload enabled
flutter run -d linux

# With verbose logging
flutter run -d linux -v
```

### Using Make Commands

The project includes a Makefile for common tasks:

```bash
make help          # Show all available commands
make run-linux     # Run the application on Linux
make build         # Build release version
make test          # Run tests
make coverage      # Generate coverage report
make analyze       # Run static analysis
make clean         # Clean build files
make format        # Format code
make deps          # Install dependencies
```

---

## 📚 Architecture

### Clean Architecture

The project follows Clean Architecture principles with clear layer separation:

- **Presentation Layer**: UI components, widgets, BLoC state management
- **Domain Layer**: Business logic, entities, use cases
- **Data Layer**: Repositories, data sources, external integrations

### State Management

Uses **BLoC (Business Logic Component)** pattern via `flutter_bloc` for predictable state management:

- **Events**: User actions and system events
- **States**: UI state representations
- **BLoC**: Business logic processing events and emitting states

### Key Technologies

- **flutter_bloc**: State management
- **equatable**: Value equality for states and events
- **file_picker**: Directory and file selection
- **shared_preferences**: Persistent settings storage
- **pdfx**: PDF rendering and metadata extraction
- **open_filex**: Opening files with system default applications

---

## 🌍 Localization

The app supports multiple languages:

- **English** (default)
- **Russian**

Language preference is automatically saved and persists between sessions.

### For Developers

To add new translations:

1. Add strings to `lib/l10n/app_en.arb` (English)
2. Add translations to `lib/l10n/app_ru.arb` (Russian)
3. Run: `flutter gen-l10n`

Usage in code:
```dart
final l10n = AppLocalizations.of(context)!;
Text(l10n.appTitle);
```

See [LOCALIZATION.md](docs/LOCALIZATION.md) for detailed localization documentation.

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Setup

1. Fork the repository
2. Clone your fork: `git clone https://github.com/yourusername/tabularium.git`
3. Create a feature branch: `git checkout -b feature/amazing-feature`
4. Make your changes
5. Run tests: `flutter test`
6. Commit your changes: `git commit -m 'Add amazing feature'`
7. Push to the branch: `git push origin feature/amazing-feature`
8. Open a Pull Request

### Coding Guidelines

- Write clear, self-documenting code
- Add tests for new features
- Update documentation as needed
- Follow the existing code style
- Keep commits atomic and well-described
- Run `flutter analyze` before committing

---

## 🐛 Known Issues

- Thumbnail generation may be slow for very large PDF files (>100MB)
- Cabinet view performance may degrade with libraries over 1000 books
- Some PDF metadata extraction issues with non-standard PDF files

---

## 📝 Roadmap

### Planned Features

- [ ] **Cloud Sync**: Optional sync with cloud storage services
- [ ] **Reading Progress**: Track reading progress and last read page
- [ ] **Book Notes**: Add notes and annotations to books
- [ ] **Advanced Search**: Filter by author, date, page count, etc.
- [ ] **Import/Export**: Export library configuration and import from other apps
- [ ] **Statistics**: View reading statistics and library analytics
- [ ] **Collections**: Group shelves into larger collections
- [ ] **Tags**: Add custom tags to books for flexible organization
- [ ] **Windows/macOS Support**: Expand to other desktop platforms
- [ ] **Mobile Companion**: View-only mobile app for browsing your library
- [ ] **Book Series Detection**: Automatically detect and group book series
- [ ] **Dark Mode**: Automatic theme switching based on system preferences

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **Flutter Team**: For the amazing cross-platform framework
- **Material Design**: For the beautiful design language
- **Contributors**: Thanks to all contributors who help improve Tabularium
- **Open Source Community**: For the excellent libraries and tools

---

## 📧 Contact & Support

- **Issues**: Report bugs or request features via [GitHub Issues](https://github.com/yourusername/tabularium/issues)
- **Discussions**: Join conversations in [GitHub Discussions](https://github.com/yourusername/tabularium/discussions)
- **Email**: your.email@example.com

---

## 🌟 Show Your Support

If you find Tabularium useful, please consider:

- ⭐ Starring the repository
- 🐛 Reporting bugs
- 💡 Suggesting new features
- 🔀 Contributing code
- 📢 Spreading the word

---

<p align="center">
  Made with ❤️ using Flutter
</p>

<p align="center">
  <img src="docs/images/flutter-logo.png" alt="Built with Flutter" width="100"/>
  <!-- TODO: Add Flutter logo -->
</p>
