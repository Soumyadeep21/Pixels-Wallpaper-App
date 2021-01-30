import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_app/utils/secrets.dart';

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


  /*
  *Create a secrets.dart file in utils folder and paste the following code with your own PEXELS API KEY
  *Obtain your won key at https://www.pexels.com/api/
   class Secrets {
      static const String API_KEY = 'YOUR API KEY';
   }
  */
  static const String apiKey = Secrets.API_KEY;

}
enum Order{popular,latest}
enum WallpaperOrientation {all,horizontal,vertical}
enum ViewState { Idle, Busy, MoreDataLoading, Error, NotFound}
