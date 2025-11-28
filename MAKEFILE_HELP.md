# Makefile Commands Reference

This document provides detailed information about available Makefile commands for the Tabularium project.

**Note:** Tabularium is a desktop application focused on Linux, Windows, and macOS platforms.

## Quick Start

```bash
# See all available commands
make help

# Run the application
make run-linux

# Run tests
make test

# Build release
make build-linux
```

## 🚀 Running (Development)

Run the application in development mode on desktop platforms:

| Command | Description |
|---------|-------------|
| `make run` | Run the application (Flutter chooses the device) |
| `make run-linux` | Run on Linux |
| `make run-windows` | Run on Windows |
| `make run-macos` | Run on macOS |

**Example:**
```bash
# Run on Linux
make run-linux

# Run on Windows
make run-windows

# Run on macOS
make run-macos
```

## 🏗️ Building (Release)

Build release versions for desktop platforms:

| Command | Description | Output Location |
|---------|-------------|-----------------|
| `make build` | Build for current platform (defaults to Linux) | `build/linux/x64/release/bundle/` |
| `make build-linux` | Build Linux release | `build/linux/x64/release/bundle/` |
| `make build-windows` | Build Windows release | `build/windows/x64/runner/Release/` |
| `make build-macos` | Build macOS release | `build/macos/Build/Products/Release/` |

**Example:**
```bash
# Build Linux release
make build-linux

# Build Windows release
make build-windows

# Build for multiple platforms
make build-linux build-windows build-macos
```

## 🧪 Testing

Run tests and generate coverage reports:

| Command | Description |
|---------|-------------|
| `make test` | Run all tests |
| `make test-unit` | Run unit tests only |
| `make test-verbose` | Run tests with verbose output |
| `make test-watch` | Run tests in watch mode (auto-rerun on changes) |
| `make coverage` | Run tests with coverage analysis |
| `make coverage-html` | Generate and open HTML coverage report |

**Example:**
```bash
# Run all tests
make test

# Generate coverage report
make coverage-html
```

**Coverage Report:**
- Coverage data is saved to `coverage/lcov.info`
- HTML report is generated in `coverage/html/`
- Opens automatically in your browser

## ✨ Code Quality

Maintain code quality with formatting, linting, and checks:

| Command | Description |
|---------|-------------|
| `make format` | Format code (modifies files) |
| `make format-check` | Check code formatting (no modifications) |
| `make lint` | Run linter (flutter analyze) |
| `make check` | Run all checks (format-check + lint + test) |
| `make pre-commit` | Run pre-commit checks (same as `check`) |

**Example:**
```bash
# Format all code
make format

# Check if code is properly formatted
make format-check

# Run all quality checks
make check
```

## 🛠️ Development & Maintenance

Development utilities and maintenance tasks:

| Command | Description |
|---------|-------------|
| `make gen-mocks` | Generate mocks for tests (using build_runner) |
| `make clean` | Clean build artifacts and coverage data |
| `make deps` | Install dependencies (flutter pub get) |
| `make deps-upgrade` | Update dependencies (flutter pub upgrade) |
| `make deps-outdated` | Show outdated dependencies |
| `make devices` | Show available devices |
| `make doctor` | Run Flutter doctor with verbose output |

**Example:**
```bash
# Install dependencies
make deps

# Clean build artifacts
make clean

# Check Flutter setup
make doctor
```

## 🔧 Platform Setup

Enable platform support for desktop platforms:

| Command | Description |
|---------|-------------|
| `make enable-linux` | Enable Linux desktop support |
| `make enable-windows` | Enable Windows desktop support |
| `make enable-macos` | Enable macOS desktop support |
| `make enable-all-platforms` | Enable all desktop platforms at once |

**Example:**
```bash
# Enable all desktop platforms
make enable-all-platforms

# Enable specific platforms
make enable-linux enable-windows
```

## 🔒 Pre-commit Hook

The project includes a pre-commit hook that automatically runs before each commit. It checks:

1. ✅ Code formatting (`make format-check`)
2. ✅ Linter (`make lint`)
3. ✅ Tests (`make test`)

The commit will be **blocked** if any check fails.

**Manual pre-commit check:**
```bash
make pre-commit
```

**Location:** `.git/hooks/pre-commit`

## 📊 Common Workflows

### Development Workflow
```bash
# 1. Install dependencies
make deps

# 2. Generate mocks
make gen-mocks

# 3. Run the app
make run-linux

# 4. Run tests
make test
```

### Release Workflow
```bash
# 1. Run all checks
make check

# 2. Build release
make build-linux

# 3. Test the release
./build/linux/x64/release/bundle/tabularium
```

### Adding New Tests
```bash
# 1. Write tests in test/ directory

# 2. Generate mocks if needed
make gen-mocks

# 3. Run tests
make test

# 4. Check coverage
make coverage-html
```

### Before Committing
```bash
# Format code
make format

# Run pre-commit checks
make pre-commit

# Or use the check command
make check
```

## 🎯 Tips

1. **Use tab completion:** Most shells support tab completion for Makefile targets
2. **Run multiple commands:** `make clean deps test`
3. **Check help anytime:** `make help`
4. **View available devices:** `make devices` before running
5. **Check Flutter setup:** `make doctor` if you have issues

## 📝 Notes

- **Linux:** Primary development platform for this project
- **Windows/macOS:** Fully supported desktop platforms
- **Target Platforms:** Desktop only (Linux, Windows, macOS)
- **Mobile/Web:** Not supported - Tabularium is a desktop application

## 🐛 Troubleshooting

**Tests failing?**
```bash
make test-verbose  # See detailed output
```

**Build failing?**
```bash
make clean
make deps
make build-linux
```

**Coverage report not opening?**
```bash
# Manually open the report
xdg-open coverage/html/index.html  # Linux
open coverage/html/index.html      # macOS
start coverage/html/index.html     # Windows
```

**Desktop platform not available?**
```bash
make enable-all-platforms
make doctor
```

## 📚 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Flutter Desktop](https://flutter.dev/desktop)
- [Flutter Testing](https://flutter.dev/docs/testing)
- [Makefile Tutorial](https://makefiletutorial.com/)
