import 'package:get_storage/get_storage.dart';

class MySharedPref {
  // get storage
  static late final GetStorage _storage;

  // STORING KEYS
  static const String _userToken = 'user_token';

  /// init get storage services
  static init() async {
    await GetStorage.init();
    _storage = GetStorage();
  }



  static void setUserToken(String? userToken) => _storage.write(_userToken, userToken);

  /// takse a function that listens to changes to userToken
  static void userTokenListener(void Function(dynamic x) listener) =>
      _storage.listenKey(_userToken, listener);

  static String? get getToken => _storage.read(_userToken) == 'null' ? null : _storage.read(_userToken);
}
