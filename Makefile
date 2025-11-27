.PHONY: help run run-linux run-web test test-watch coverage clean build gen-mocks format lint

# Show help
help:
	@echo "Available commands:"
	@echo "  make run         - Run the application (platform selection)"
	@echo "  make run-linux   - Run on Linux"
	@echo "  make run-web     - Run in browser"
	@echo "  make test        - Run all tests"
	@echo "  make test-watch  - Run tests in watch mode"
	@echo "  make coverage    - Run tests with coverage and generate HTML report"
	@echo "  make gen-mocks   - Generate mocks for tests"
	@echo "  make format      - Format code"
	@echo "  make lint        - Run linter"
	@echo "  make clean       - Clean build artifacts"
	@echo "  make build       - Build release version"

# Run the application
run:
	flutter run

# Run on Linux
run-linux:
	flutter run -d linux

# Run in browser
run-web:
	flutter run -d chrome

# Run all tests
test:
	flutter test

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
	flutter test --coverage
	@echo "Generating HTML report..."
	genhtml coverage/lcov.info -o coverage/html
	@echo "Coverage report created at coverage/html/index.html"
	@echo "Open report: xdg-open coverage/html/index.html"

# Generate mocks for tests
gen-mocks:
	dart run build_runner build --delete-conflicting-outputs

# Format code
format:
	dart format lib/ test/

# Run linter
lint:
	flutter analyze

# Clean build artifacts
clean:
	flutter clean
	rm -rf coverage/

# Build release version for Linux
build:
	flutter build linux --release

# Install dependencies
deps:
	flutter pub get

# Update dependencies
deps-upgrade:
	flutter pub upgrade

# Show outdated dependencies
deps-outdated:
	flutter pub outdated
