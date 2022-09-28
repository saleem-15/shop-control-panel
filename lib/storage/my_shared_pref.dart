import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../../config/translations/localization_service.dart';

class MySharedPref {
  // get storage
  static late final GetStorage _storage;

  // STORING KEYS
  static const String _fcmTokenKey = 'fcm_token';
  static const String _currentLocalKey = 'current_local';
  static const String _lightThemeKey = 'is_theme_light';
  static const String _userToken = 'user_token';

  /// init get storage services
  static init() async {
    await GetStorage.init();
    _storage = GetStorage();
  }

  /// set theme current type as light theme
  static void setThemeIsLight(bool lightTheme) => _storage.write(_lightThemeKey, lightTheme);

  /// get if the current theme type is light
  static bool getThemeIsLight() => _storage.read(_lightThemeKey) ?? true;

  /// save current locale
  static void setCurrentLanguage(String languageCode) => _storage.write(_currentLocalKey, languageCode);

  /// get current locale
  static Locale getCurrentLocal() {
    String? langCode = _storage.read(_currentLocalKey);
    // default language is english
    if (langCode == null) {
      return LocalizationService.defaultLanguage;
    }
    return LocalizationService.supportedLanguages[langCode]!;
  }

  static void setUserToken(String? userToken) => _storage.write(_userToken, userToken);

  /// takse a function that listens to changes to userToken
  static void userTokenListener(void Function(dynamic x) listener) =>
      _storage.listenKey(_userToken, listener);

  static String? get getToken => _storage.read(_userToken) == 'null' ? null : _storage.read(_userToken);

  /// get generated fcm token
  static String? getFcmToken() => _storage.read(_fcmTokenKey);
}
