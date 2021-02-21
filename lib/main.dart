import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_app/services/dark_mode.dart';
import 'package:wallpaper_app/config/preferences.dart';
import 'package:wallpaper_app/utils/config_page.dart';
import 'package:wallpaper_app/utils/wallpaper_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WallpaperApp.prefs = await SharedPreferences.getInstance();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DarkMode>(
          create: (_) => DarkMode(
              WallpaperApp.prefs.getBool(WallpaperApp.darkModePref) ?? false),
        ),
        ChangeNotifierProvider<Preferences>(
          create: (_) => Preferences(
            myOrder: WallpaperApp.prefs.getString(WallpaperApp.orderPref),
            myWallpaperOrientation:
                WallpaperApp.prefs.getString(WallpaperApp.orientationPref),
            mySafeSearch:
                WallpaperApp.prefs.getBool(WallpaperApp.safeSearchPref),
          ),
        ),
      ],
      child: ConfigPage(),
    );
  }
}
