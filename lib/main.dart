import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'database_helper.dart';
import 'home.dart';
import 'language_provider.dart';
import 'theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.initializeDatabase();
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