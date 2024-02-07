import 'package:flutter/material.dart';
import 'package:poc_project/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'language_provider.dart';
import 'list_view_page.dart';
import 'otp_screen.dart';

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
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ListViewPage()),
            );
          },
          child: const Text('Go to List View Page'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OTPScreen()),
            );
          },
          child: const Text('Go to OTP Page'),
        ),
      ],
    );
  }
}