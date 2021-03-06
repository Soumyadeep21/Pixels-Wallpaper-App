import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/services/dark_mode.dart';
import 'package:wallpaper_app/pages/root_page.dart';
import 'package:wallpaper_app/utils/wallpaper_app.dart';

class ConfigPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = Provider.of<DarkMode>(context).isDarkModeOn;
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: WallpaperApp.appName,
        theme: ThemeData(
          fontFamily: WallpaperApp.notoSans,
          scaffoldBackgroundColor: Colors.transparent,
          brightness: isDarkModeOn ? Brightness.dark : Brightness.light,
          backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
          cardColor: isDarkModeOn ? Colors.black87 : Colors.white,
          primaryColor: isDarkModeOn ? Colors.black : Colors.white,
          buttonColor: isDarkModeOn ? Colors.green : Colors.blue,
          buttonTheme: ButtonThemeData().copyWith(
            colorScheme:
                isDarkModeOn ? ColorScheme.dark() : ColorScheme.light(),
          ),
        ),
        home: RootPage(),
      ),
    );
  }
}
