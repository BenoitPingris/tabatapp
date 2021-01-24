import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabatapp/models/training.dart';

class TrainingsService {
  Future<SharedPreferences> get prefs async {
    return SharedPreferences.getInstance();
  }
}
