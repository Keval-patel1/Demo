import 'package:demo/utils/shared_preferences/shared_preference_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static Future<void> storeData(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> storedList = sharedPreferences.getStringList(storeList) ?? [];

    if (!storedList.contains(id)) {
      storedList.add(id);
      await sharedPreferences.setStringList(storeList, storedList);
    }
  }

  static Future<bool> checkIdAvailable(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> storedList = sharedPreferences.getStringList(storeList) ?? [];
    if (storedList.contains(id)) {
      return true;
    }
    return false;
  }
}