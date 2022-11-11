import 'package:shared_preferences/shared_preferences.dart';

const String isLogin = 'isLogin';
const String accessToken = 'accessToken';
const String userId = 'userId';
const String latitude = 'latitude';
const String longitude = 'longitude';
const String address = 'address';
checkPrefKey(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.containsKey(key);
}

Future<String?>? getPrefStringValue(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

setPrefStringValue(String key, value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

getPrefBoolValue(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key);
}

setPrefBoolValue(String key, value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

getPrefIntValue(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt(key);
}

setPrefIntValue(String key, value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

getPrefDoubleValue(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getDouble(key);
}

setPrefDoubleValue(String key, value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setDouble(key, value);
}

removePrefValue(String key) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}
