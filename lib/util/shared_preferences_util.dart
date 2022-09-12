import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {
  static const LANGUAGE_CODE_ID = "LANGUAGE_CODE_ID";

  static final SharedPreferenceUtil _instance =
      SharedPreferenceUtil._internal();

  factory SharedPreferenceUtil() {
    return _instance;
  }

  SharedPreferenceUtil._internal();

  static late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<String> getLanguageCode() async {
    var languageCode = _prefs.getString(LANGUAGE_CODE_ID);
    return languageCode ?? 'vi';
  }

  Future<void> setLanguageCode(String languageCode) async {
    _prefs.setString(LANGUAGE_CODE_ID, languageCode);
  }
}
