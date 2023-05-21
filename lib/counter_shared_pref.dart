import 'package:shared_preferences/shared_preferences.dart';

class CounterSharedPref {
  final String counterKey = 'counter';

  // save counter value
  Future<bool> saveData(int counter) async {
    final pref = await SharedPreferences.getInstance();

    bool saveCounter = await pref.setInt(counterKey, counter);
    return saveCounter;
  }

  Future<int> getData() async {
    final pref = await SharedPreferences.getInstance();

    final value = pref.getInt(counterKey) ?? 0;
    return value;
  }

  Future<bool> removeData() async {
    final pref = await SharedPreferences.getInstance();

    return await pref.remove(counterKey);
  }
}
