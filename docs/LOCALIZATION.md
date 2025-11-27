# Localization (i18n) Guide

This document describes how to use and extend localization in the Tabularium app.

## Overview

The app uses Flutter's official localization system with ARB (Application Resource Bundle) files.

**Supported languages:**
- English (en) - Default
- Russian (ru)

## Structure

```
lib/
├── l10n/
│   ├── app_en.arb    # English translations
│   └── app_ru.arb    # Russian translations
├── core/
│   └── services/
│       ├── language_service.dart      # Language management
│       └── language_provider.dart     # Widget tree provider
└── [auto-generated]/
    └── flutter_gen/
        └── gen_l10n/
            └── app_localizations.dart # Generated localization code
```

## Adding New Translations

### 1. Add to English ARB file (`lib/l10n/app_en.arb`)

```json
{
  "newKey": "New text in English",
  "@newKey": {
    "description": "Description of what this text is for"
  }
}
```

### 2. Add to Russian ARB file (`lib/l10n/app_ru.arb`)

```json
{
  "newKey": "Новый текст на русском"
}
```

### 3. Regenerate localization files

```bash
flutter gen-l10n
```

Or simply run the app:
```bash
make run-linux
```

## Using Translations in Code

### Simple text

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// In your widget
@override
Widget build(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;

  return Text(l10n.appTitle);
}
```

### Text with placeholders

**ARB file:**
```json
{
  "greeting": "Hello, {name}!",
  "@greeting": {
    "placeholders": {
      "name": {
        "type": "String"
      }
    }
  }
}
```

**Dart code:**
```dart
Text(l10n.greeting('John'))
```

### Plural forms

**ARB file:**
```json
{
  "itemCount": "{count, plural, =0{No items} =1{One item} other{{count} items}}",
  "@itemCount": {
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  }
}
```

**Dart code:**
```dart
Text(l10n.itemCount(5))  // "5 items"
```

## Changing Language Programmatically

### Using LanguageProvider

```dart
import 'package:tabularium/core/services/language_provider.dart';

// Get language service
final languageService = LanguageProvider.of(context);

// Change to Russian
await languageService.changeLanguage(const Locale('ru'));

// Change to English
await languageService.changeLanguage(const Locale('en'));

// Get current locale
final currentLocale = languageService.currentLocale;
```

### Example: Language Selector Widget

```dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tabularium/core/services/language_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final languageService = LanguageProvider.of(context);
    final l10n = AppLocalizations.of(context)!;

    return DropdownButton<Locale>(
      value: languageService.currentLocale,
      items: [
        DropdownMenuItem(
          value: const Locale('en'),
          child: Text(l10n.languageEnglish),
        ),
        DropdownMenuItem(
          value: const Locale('ru'),
          child: Text(l10n.languageRussian),
        ),
      ],
      onChanged: (locale) {
        if (locale != null) {
          languageService.changeLanguage(locale);
        }
      },
    );
  }
}
```

## Adding a New Language

### 1. Create new ARB file

Create `lib/l10n/app_<language_code>.arb` (e.g., `app_de.arb` for German):

```json
{
  "@@locale": "de",
  "appTitle": "Tabularium",
  "appSubtitle": "Ihre persönliche Bibliothek",
  ...
}
```

### 2. Update LanguageService

Edit `lib/core/services/language_service.dart`:

```dart
static List<Locale> get supportedLocales => const [
  Locale('en'), // English
  Locale('ru'), // Russian
  Locale('de'), // German - NEW
];
```

### 3. Add language names to ARB files

In `app_en.arb`:
```json
{
  "languageGerman": "German"
}
```

In `app_ru.arb`:
```json
{
  "languageGerman": "Немецкий"
}
```

In `app_de.arb`:
```json
{
  "languageGerman": "Deutsch"
}
```

### 4. Regenerate

```bash
flutter gen-l10n
```

## Language Persistence

The selected language is automatically saved to `SharedPreferences` and will be restored when the app restarts.

**Storage key:** `app_language`

## Testing

When writing widget tests, wrap your widget with localization:

```dart
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

testWidgets('My widget test', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
      ],
      home: MyWidget(),
    ),
  );

  // Your test code
});
```

## Configuration Files

### `pubspec.yaml`
```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: any

flutter:
  generate: true
```

### `l10n.yaml`
```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

## Best Practices

1. **Use descriptive keys**: `selectBooksDirectory` instead of `btn1`
2. **Add descriptions**: Always include `@key` description in ARB files
3. **Keep consistent**: Use the same key format across all languages
4. **Avoid hardcoded strings**: All user-visible text should be localized
5. **Test both languages**: Ensure UI looks good in both languages
6. **Consider text length**: Russian text is often longer than English

## Common Issues

### Generated files not found

Run:
```bash
flutter pub get
flutter gen-l10n
```

### App doesn't change language

Make sure:
1. `LanguageProvider` is in the widget tree
2. You're using `ListenableBuilder` to rebuild on changes
3. Locale is set on `MaterialApp`

### Missing translations

- Check that the key exists in all ARB files
- Verify ARB syntax (valid JSON)
- Regenerate localization files
