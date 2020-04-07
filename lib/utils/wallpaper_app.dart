import 'package:shared_preferences/shared_preferences.dart';

class WallpaperApp{
  static const String appName = 'Pixels';
  static const String appVersion = '1.0.2';
  static const bool isDebugMode = false;

  static const String notoSans = 'NotoSans';

  static SharedPreferences prefs;
  static const String darkModePref = 'DarkMode'; 
  static const String orderPref = 'Order';
  static const String orientationPref = 'Orientation';
  static const String safeSearchPref = 'SafeSearch';

  static const String apiKey = 'YOUR-API-KEY';

}
enum Order{popular,latest}
enum WallpaperOrientation {all,horizontal,vertical}
enum ViewState { Idle, Busy, MoreDataLoading, Error, NotFound}
