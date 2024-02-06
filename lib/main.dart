import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'language_provider.dart';
import 'theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider())
      ],
      child: const POCApp(),
    ),
  );
}

class POCApp extends StatelessWidget {
  const POCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Provider.of<LanguageProvider>(context).currentLocal,
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      darkTheme: Provider.of<ThemeProvider>(context).currentTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        appBar: AppBar(
            title: Text("POC",
                style: TextStyle(
                    color:
                        Provider.of<ThemeProvider>(context).textTitleColour)),
            backgroundColor: Provider.of<ThemeProvider>(context).background),
        body: const Center(
          child: Home(),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isTamilMode = false;
  bool _isDarkMode = false;

  final MaterialStateProperty<Icon?> themeIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.dark_mode, color: Colors.white);
      }
      return const Icon(Icons.light_mode, color: Colors.white);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(AppLocalizations.of(context)!.language),
        Switch(
          value: _isTamilMode,
          inactiveTrackColor: Provider.of<ThemeProvider>(context).background,
          activeTrackColor: Provider.of<ThemeProvider>(context).background,
          inactiveThumbColor: Colors.green,
          trackOutlineColor: MaterialStateProperty.all<Color>(Colors.green),
          trackOutlineWidth: MaterialStateProperty.all<double>(1.0),
          activeColor: Colors.green,
          onChanged: (bool value) {
            setState(() {
              Provider.of<LanguageProvider>(context, listen: false)
                  .toggleLocal();
              _isTamilMode = value;
            });
          },
        ),
        Text(AppLocalizations.of(context)!.theme),
        Switch(
          thumbIcon: themeIcon,
          value: _isDarkMode,
          inactiveTrackColor: Provider.of<ThemeProvider>(context).background,
          activeTrackColor: Provider.of<ThemeProvider>(context).background,
          inactiveThumbColor: Colors.green,
          trackOutlineColor: MaterialStateProperty.all<Color>(Colors.green),
          trackOutlineWidth: MaterialStateProperty.all<double>(1.0),
          activeColor: Colors.green,
          onChanged: (bool value) {
            setState(() {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
              _isDarkMode = value;
            });
          },
        ),
      ],
    );
  }
}
