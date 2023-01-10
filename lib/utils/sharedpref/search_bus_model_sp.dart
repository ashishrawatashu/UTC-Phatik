import 'package:shared_preferences/shared_preferences.dart';
import 'package:utc_flutter_app/constants/strings.dart';

class SaveSearchBusSP {
  static late SharedPreferences prefs;

  static Future<bool?> init() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  static void setSourcePlace({ required String sourcePlace}) {
    prefs.setString(StringsFile.sourcePlace, sourcePlace);
  }

  static String? getSourcePlace() {
    return prefs.getString(StringsFile.sourcePlace);
  }

  static void setDestinationPlace({ required String destinationPlace}) {
    prefs.setString(StringsFile.destinationPlace, destinationPlace);
  }

  static String? getIDestinationPlace() {
    return prefs.getString(StringsFile.destinationPlace);
  }

  static void setToFromPlace({ required String toFrom}) {
    prefs.setString(StringsFile.toFrom, toFrom);
  }

  static String? getToFromPlace() {
    return prefs.getString(StringsFile.toFrom);
  }

}
