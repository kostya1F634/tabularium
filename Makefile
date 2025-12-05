.PHONY: help run run-linux run-windows run-macos test test-unit test-verbose test-watch coverage coverage-html clean build build-linux build-windows build-macos gen-mocks format format-check lint check pre-commit deps deps-upgrade deps-outdated devices doctor enable-linux enable-windows enable-macos enable-all-platforms install uninstall

# Show help
help:
	@echo "Available commands:"
	@echo ""
	@echo "Running (Development):"
	@echo "  make run            - Run the application (platform selection)"
	@echo "  make run-linux      - Run on Linux"
	@echo "  make run-windows    - Run on Windows"
	@echo "  make run-macos      - Run on macOS"
	@echo ""
	@echo "Building (Release):"
	@echo "  make build          - Build release for current platform (Linux)"
	@echo "  make build-linux    - Build Linux release"
	@echo "  make build-windows  - Build Windows release"
	@echo "  make build-macos    - Build macOS release"
	@echo ""
	@echo "Testing:"
	@echo "  make test           - Run all tests"
	@echo "  make test-unit      - Run unit tests only"
	@echo "  make test-verbose   - Run tests with verbose output"
	@echo "  make test-watch     - Run tests in watch mode"
	@echo "  make coverage       - Run tests with coverage"
	@echo "  make coverage-html  - Generate HTML coverage report and open it"
	@echo ""
	@echo "Code Quality:"
	@echo "  make format         - Format code"
	@echo "  make format-check   - Check code formatting"
	@echo "  make lint           - Run linter"
	@echo "  make check          - Run format check, lint, and tests"
	@echo "  make pre-commit     - Run all pre-commit checks"
	@echo ""
	@echo "Development & Maintenance:"
	@echo "  make gen-mocks      - Generate mocks for tests"
	@echo "  make clean          - Clean build artifacts"
	@echo "  make deps           - Install dependencies"
	@echo "  make deps-upgrade   - Update dependencies"
	@echo "  make deps-outdated  - Show outdated dependencies"
	@echo "  make devices        - Show available devices"
	@echo "  make doctor         - Run Flutter doctor"
	@echo ""
	@echo "Platform Setup:"
	@echo "  make enable-linux   - Enable Linux desktop support"
	@echo "  make enable-windows - Enable Windows desktop support"
	@echo "  make enable-macos   - Enable macOS desktop support"
	@echo "  make enable-all-platforms - Enable all desktop platforms"
	@echo ""
	@echo "Deployment (Linux):"
	@echo "  make install        - Install application to /opt/tabularium"
	@echo "  make uninstall      - Remove installed application"

# ============================================================================
# Running (Development)
# ============================================================================

# Run the application (let Flutter choose the device)
run:
	@echo "Running application..."
	@flutter run

# Run on Linux
run-linux:
	@echo "Running on Linux..."
	@flutter run -d linux

run-linux-release:
	@echo "Running release on Linux..."
	@./build/linux/x64/release/bundle/tabularium

# Run on Windows
run-windows:
	@echo "Running on Windows..."
	@flutter run -d windows

# Run on macOS
run-macos:
	@echo "Running on macOS..."
	@flutter run -d macos


# ============================================================================
# Building (Release)
# ============================================================================

# Build release version (alias for build-linux on Linux systems)
build:
	@echo "Building release version..."
	@flutter build linux --release

# Build Linux release
build-linux:
	@echo "Building Linux release..."
	@flutter build linux --release
	@echo "✓ Linux build completed: build/linux/x64/release/bundle/"

# Build Windows release
build-windows:
	@echo "Building Windows release..."
	@flutter build windows --release
	@echo "✓ Windows build completed: build/windows/x64/runner/Release/"

# Build macOS release
build-macos:
	@echo "Building macOS release..."
	@flutter build macos --release
	@echo "✓ macOS build completed: build/macos/Build/Products/Release/"

# ============================================================================
# Testing
# ============================================================================

# Run all tests
test:
	@echo "Running all tests..."
	@flutter test

# Run unit tests only
test-unit:
	@echo "Running unit tests..."
	@flutter test test/

# Run tests with verbose output
test-verbose:
	@echo "Running tests with verbose output..."
	@flutter test --reporter expanded

# Run tests in watch mode
test-watch:
	@echo "Running tests in watch mode..."
	@while true; do \
		flutter test; \
		inotifywait -qre modify lib/ test/; \
	done

# Run tests with coverage
coverage:
	@echo "Running tests with coverage..."
	@flutter test --coverage
	@echo "Coverage data saved to coverage/lcov.info"
	@echo "To generate HTML report: make coverage-html"

# Generate HTML coverage report and open it
coverage-html: coverage
	@echo "Generating HTML coverage report..."
	@which genhtml > /dev/null || (echo "Error: genhtml not found. Install lcov: sudo apt install lcov" && exit 1)
	@genhtml coverage/lcov.info -o coverage/html --quiet
	@echo "Coverage report created at coverage/html/index.html"
	@echo "Opening coverage report..."
	@xdg-open coverage/html/index.html 2>/dev/null || open coverage/html/index.html 2>/dev/null || echo "Please open coverage/html/index.html manually"

# ============================================================================
# Code Quality
# ============================================================================

# Generate mocks for tests
gen-mocks:
	@echo "Generating mocks for tests..."
	@dart run build_runner build --delete-conflicting-outputs

# Format code
format:
	@echo "Formatting code..."
	@dart format lib/ test/

# Check code formatting without modifying files
format-check:
	@echo "Checking code formatting..."
	@dart format --set-exit-if-changed lib/ test/

# Run linter
lint:
	@echo "Running linter..."
	@flutter analyze --no-fatal-infos

# Run all checks (format, lint, tests)
check: format-check lint test
	@echo "✓ All checks passed!"

# Pre-commit hook (format, lint, tests)
pre-commit:
	@echo "Running pre-commit checks..."
	@make format-check || (echo "✗ Format check failed! Run 'make format' to fix." && exit 1)
	@make lint || (echo "✗ Lint failed! Fix the issues above." && exit 1)
	@make test || (echo "✗ Tests failed! Fix the failing tests." && exit 1)
	@echo "✓ All pre-commit checks passed!"

# ============================================================================
# Development & Maintenance
# ============================================================================

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	@flutter clean
	@rm -rf coverage/
	@echo "✓ Clean completed"

# Install dependencies
deps:
	@echo "Installing dependencies..."
	@flutter pub get

# Update dependencies
deps-upgrade:
	@echo "Updating dependencies..."
	@flutter pub upgrade

# Show outdated dependencies
deps-outdated:
	@echo "Checking for outdated dependencies..."
	@flutter pub outdated

# Show Flutter devices
devices:
	@echo "Available devices:"
	@flutter devices

# Show Flutter doctor
doctor:
	@flutter doctor -v

# Enable platform support
enable-linux:
	@echo "Enabling Linux support..."
	@flutter config --enable-linux-desktop

enable-windows:
	@echo "Enabling Windows support..."
	@flutter config --enable-windows-desktop

enable-macos:
	@echo "Enabling macOS support..."
	@flutter config --enable-macos-desktop

enable-all-platforms:
	@echo "Enabling all desktop platforms..."
	@flutter config --enable-linux-desktop
	@flutter config --enable-windows-desktop
	@flutter config --enable-macos-desktop
	@echo "✓ All desktop platforms enabled"

# ============================================================================
# Deployment (Linux)
# ============================================================================

# Install application to /opt/tabularium
install-linux: build-linux
	@echo "Installing Tabularium to /opt/tabularium..."
	@if [ ! -d "./build/linux/x64/release/bundle" ]; then \
		echo "Error: Release build not found. Run 'make build-linux' first."; \
		exit 1; \
	fi
	@echo "Creating installation directory..."
	@sudo mkdir -p /opt/tabularium
	@echo "Copying application files..."
	@sudo cp -r ./build/linux/x64/release/bundle/* /opt/tabularium/
	@echo "Creating desktop entry..."
	@echo "[Desktop Entry]" | sudo tee /usr/share/applications/tabularium.desktop > /dev/null
	@echo "Name=Tabularium" | sudo tee -a /usr/share/applications/tabularium.desktop > /dev/null
	@echo "Comment=Your Personal PDF Library Manager" | sudo tee -a /usr/share/applications/tabularium.desktop > /dev/null
	@echo "Exec=/opt/tabularium/tabularium" | sudo tee -a /usr/share/applications/tabularium.desktop > /dev/null
	@echo "Icon=/opt/tabularium/data/flutter_assets/assets/icon.png" | sudo tee -a /usr/share/applications/tabularium.desktop > /dev/null
	@echo "Terminal=false" | sudo tee -a /usr/share/applications/tabularium.desktop > /dev/null
	@echo "Type=Application" | sudo tee -a /usr/share/applications/tabularium.desktop > /dev/null
	@echo "Categories=Office;Viewer;" | sudo tee -a /usr/share/applications/tabularium.desktop > /dev/null
	@sudo chmod 644 /usr/share/applications/tabularium.desktop
	@echo "Updating desktop database..."
	@sudo update-desktop-database /usr/share/applications/ 2>/dev/null || true
	@echo "✓ Installation completed!"
	@echo "You can now launch Tabularium from your application menu."

# Uninstall application
uninstall-linux:
	@echo "Uninstalling Tabularium..."
	@if [ -d "/opt/tabularium" ]; then \
		echo "Removing application files..."; \
		sudo rm -rf /opt/tabularium; \
		echo "✓ Application files removed"; \
	else \
		echo "Application directory not found, skipping..."; \
	fi
	@if [ -f "/usr/share/applications/tabularium.desktop" ]; then \
		echo "Removing desktop entry..."; \
		sudo rm -f /usr/share/applications/tabularium.desktop; \
		echo "✓ Desktop entry removed"; \
	else \
		echo "Desktop entry not found, skipping..."; \
	fi
	@echo "Updating desktop database..."
	@sudo update-desktop-database /usr/share/applications/ 2>/dev/null || true
	@echo "✓ Tabularium has been uninstalled"
