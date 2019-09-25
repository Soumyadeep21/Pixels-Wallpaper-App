import 'package:shared_preferences/shared_preferences.dart';

class WallpaperApp{
  static const String appName = 'Wallpaper App';
  static const String appVersion = '1.0.0';
  static const bool isDebugMode = true;

  static const String notoSans = 'NotoSans';

  static SharedPreferences prefs;
  static const String darkModePref = 'DarkMode'; 
  static const String orderPref = 'Order';
  static const String orientationPref = 'Orientation';
  static const String safeSearchPref = 'SafeSearch';

  static const String apiKey = '11308358-67ad92507710cb90567e4924c';

}
enum Order{popular,latest}
enum WallpaperOrientation {all,horizontal,vertical}
enum ViewState { Idle, Busy, MoreDataLoading, Error, NotFound}