import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  bool _isTamilMode = false;

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
