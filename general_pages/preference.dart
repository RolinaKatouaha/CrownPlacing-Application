import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static const String authorization = "AUTHORIZATION";

  static const String usertype = "";
  static const String userid = "";
  static Future<SharedPreferences> initState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  /// ------------------ SINGLETON -----------------------
  static final Preference _preference = Preference._internal();

  factory Preference() {
    return _preference;
  }

  Preference._internal();

  static Preference get shared => _preference;
}
