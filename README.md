# 📚 Tabularium

**Your Personal PDF Library Manager**

A modern desktop application for organizing and managing your PDF book collection with custom shelves, search, and beautiful themes.

[![Flutter](https://img.shields.io/badge/Flutter-3.27.1-02569B?logo=flutter)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20Windows%20%7C%20macOS-blue)](https://github.com/yourusername/tabularium)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

---

## 🎯 What is Tabularium?

Tabularium is a **local-first** desktop application that helps you organize your PDF book collection. Point it to your books folder, and it automatically scans, indexes, and generates cover thumbnails. Organize books into custom shelves, search your library, and switch between grid and 3D cabinet views.

**Key principle:** Your data stays on your machine. No cloud, no tracking, no subscriptions.

---

## ✨ Features

- 📁 **Automatic Scanning** - Point to your books folder and let Tabularium handle the rest
- 🗂️ **Custom Shelves** - Organize books by topic, author, or any category you choose
- 🔍 **Fast Search** - Find books instantly by title, author, or filename
- 🎨 **24+ Themes** - Choose from a wide variety of beautiful color schemes
- 🌍 **15 Languages** - English, Russian, Chinese, German, French, Spanish, Italian, Portuguese, Japanese, Korean, Hindi, Arabic, Turkish, Dutch, Danish, Polish
- 📊 **Multiple Views** - Switch between grid and 3D cabinet bookshelf views
- ⌨️ **Keyboard Shortcuts** - Navigate efficiently with comprehensive shortcuts
- 🖼️ **Auto Thumbnails** - Automatically generates cover images from PDFs
- 💾 **Local Storage** - Everything stays on your machine in `.tabularium.conf` files

---

## 📸 Screenshots

### Main Library View
![Main Screen](docs/images/screenshot-main.png)
*Grid view with book covers and search*

### Cabinet View
![Cabinet View](docs/images/screenshot-cabinet.png)
*3D bookshelf visualization*

### Theme Selection
![Themes](docs/images/screenshot-themes.png)
*Choose from 24+ beautiful themes*

### Welcome Screen
![Welcome](docs/images/screenshot-welcome.png)
*Simple directory selection on first launch*

---

## 🛠️ Build Requirements

### Prerequisites

- **Flutter SDK** 3.27.1 or higher
- **Dart SDK** 3.6.0+ (included with Flutter)
- **Make** (for convenient build commands)
- Platform-specific build tools (see below)

### Linux Dependencies

#### Ubuntu/Debian
```bash
sudo apt install clang cmake ninja-build pkg-config \
  libgtk-3-dev liblzma-dev libstdc++-12-dev
```

#### Fedora/RHEL
```bash
sudo dnf install clang cmake ninja-build pkgconfig \
  gtk3-devel xz-devel
```

#### Arch/Manjaro
```bash
sudo pacman -S clang cmake ninja pkgconf gtk3 xz
```

### Windows Dependencies

Install Visual Studio 2022 with "Desktop development with C++" workload.

### macOS Dependencies

```bash
xcode-select --install
```

---

## 🚀 Building from Source

### 1. Install Flutter

Download and install Flutter from [flutter.dev](https://docs.flutter.dev/get-started/install).

Verify installation:
```bash
flutter doctor
```

### 2. Clone Repository

```bash
git clone https://github.com/yourusername/tabularium.git
cd tabularium
```

### 3. Install Dependencies

```bash
flutter pub get
flutter gen-l10n
```

### 4. Build for Your Platform

#### Linux
```bash
# Debug build
flutter build linux --debug

# Release build
flutter build linux --release
```

Output: `build/linux/x64/release/bundle/`

#### Windows
```bash
# Debug build
flutter build windows --debug

# Release build
flutter build windows --release
```

Output: `build/windows/x64/runner/Release/`

#### macOS
```bash
# Debug build
flutter build macos --debug

# Release build
flutter build macos --release
```

Output: `build/macos/Build/Products/Release/`

### 5. Run

#### From Source (all platforms)
```bash
# Linux
flutter run -d linux

# Windows
flutter run -d windows

# macOS
flutter run -d macos
```

#### From Build
```bash
# Linux
./build/linux/x64/release/bundle/tabularium

# Windows
.\build\windows\x64\runner\Release\tabularium.exe

# macOS
open build/macos/Build/Products/Release/Tabularium.app
```

---

## 🎮 Quick Start

1. **Launch** the application
2. **Select** your books directory
3. **Wait** for scanning and thumbnail generation
4. **Create shelves** and start organizing!

**Keyboard shortcuts:** Press `F1` to see all available shortcuts.

---

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

Built with [Flutter](https://flutter.dev) and ❤️

---

<p align="center">
  <strong>⭐ Star this repo if you find it useful!</strong>
</p>
