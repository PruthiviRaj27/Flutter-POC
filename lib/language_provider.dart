import 'package:flutter/material.dart';
import 'package:poc_project/preferences_manager.dart';

class LanguageProvider with ChangeNotifier {
  bool _isTamilMode = PreferencesManager().isTamilMode;

  Locale get currentLocal => _isTamilMode ? _tamilLocal : _englishLocal;

  void toggleLocal() {
    _isTamilMode = !_isTamilMode;
    notifyListeners();
  }

  Locale get _englishLocal {
    return const Locale("en");
  }

  Locale get _tamilLocal {
    return const Locale("ta");
  }
}
