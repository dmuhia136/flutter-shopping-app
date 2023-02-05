import 'package:shared_preferences/shared_preferences.dart';

class Functions {
  userId() async {
    final prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString('userid');
    return id;
  }
}
