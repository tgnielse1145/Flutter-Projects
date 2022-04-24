# repustar

## Localization

Follow below instructions carefully to setup localization in your project.

We have used flutter `provider: ^3.0.0+1` package to reflect changes in the entire app when changing the language. You can modify the code to use any state management to achieve same functionality.

## Installation

- Open `pubspec.yaml` and add `language` in `assets` field.

```yaml
assets:
  - assets/images/
  - language/
```

- Open `language/` folder. If you want to insert new language, create a file here named as `<language_code>.json`. Replace `language_code` with the language code of new language. For example

```bash
# Navigate to project directory
$touch language/en.json  # for english language
```

- Open `lib/language/app_locales.dart`. Insert language entry here. For example

```dart
static const Map<String, Locale> locales = {
    ...

    // Example: 'Language name': Locale('language code', 'country code')
    "Japanese": Locale('ja', 'JP'),
};
```

- Modify `app.dart` and add the following lines

```dart
// import all these
import 'package:repustar/language/app_locales.dart';
import 'package:repustar/language/app_localization.dart';
import 'package:repustar/language/language_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';



return MaterialApp(
    ...

    // Add below lines
    localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: AppLocales.locales.values,
    locale: Locale('en', 'US'); // This shoud be  equal to 'language' property from LanguageModel class to reflect changes in the entire app.
    localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
            if (locale != null &&
                supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
            }
        }
        return supportedLocales.first;
    },

    ...
);
```

## Usage

- Add a field in `language/ja.json`

```json
{
  "username": "ユーザー名"
}
```

- Get username is selected language using below statement

```dart
AppLocalizations.of(context).translate('username')
```

## Change default language

- To change default language for your app, navigate to `lib/language/language_model.dart` and change `language` property to desired language. For example

```dart
// change dafault language to japanese
Locale language = Locale('ja', 'JP')
```

## Complete example

Check out the full example using `provider` package

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageModel>.value(
      value: LanguageModel(),
      child: Consumer<LanguageModel>(
        builder: (context, model, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: Themes.defaultTheme,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: AppLocales.locales.values,
            locale: model.language,
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (locale != null &&
                    supportedLocale.languageCode == locale.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            initialRoute: SetupRoutes.initialRoute,
            routes: SetupRoutes.routes,
          );
        },
      ),
    );
  }
}
```

```dart
// usage in app
Text(AppLocalizations.of(context).translate('username')),

// Dropdown to change language from app itself
DropdownButton<String>(
  value: dropdownValue,
  onChanged: (String newValue) {
    dropdownValue = newValue;
    LanguageModel().changeLanguage = AppLocales.locales[newValue];
  },
  items: AppLocales.locales.keys
      .toList()
      .map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList(),
),
```
