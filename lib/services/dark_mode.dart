import 'package:flutter/widgets.dart';
import 'package:wallpaper_app/utils/wallpaper_app.dart';

class DarkMode extends ChangeNotifier{

  bool isDarkModeOn;
  DarkMode(this.isDarkModeOn);
  void changeTheme() async{
    try{
      isDarkModeOn = !isDarkModeOn;
      await WallpaperApp.prefs.setBool(WallpaperApp.darkModePref,isDarkModeOn);
      notifyListeners();
    }catch(e){
      print(e);
    }
  }

}