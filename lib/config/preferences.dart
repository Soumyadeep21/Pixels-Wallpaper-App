import 'package:flutter/foundation.dart';
import 'package:wallpaper_app/utils/wallpaper_app.dart';

class Preferences extends ChangeNotifier {
  Order order;
  WallpaperOrientation wallpaperOrientation;
  bool safeSearch;
  bool _firstTime = true;
  static Preferences singleton = Preferences._internal();
  Preferences._internal();
  factory Preferences(
      {String myOrder, bool mySafeSearch, String myWallpaperOrientation}) {
    if(singleton._firstTime)
    {
      singleton._firstTime = false;
      singleton.wallpaperOrientation = myWallpaperOrientation ==
            WallpaperOrientation.all.toString()
        ? WallpaperOrientation.all
        : (myWallpaperOrientation == WallpaperOrientation.vertical.toString() ||
                myWallpaperOrientation == null
            ? WallpaperOrientation.vertical
            : WallpaperOrientation.horizontal);
    singleton.order = myOrder == Order.popular.toString() || myOrder == null
        ? Order.popular
        : Order.latest;
    if (mySafeSearch == null) singleton.safeSearch = false;
    else singleton.safeSearch = mySafeSearch;
    }
    return singleton;
  }
  void changeOrder(Order newOrder) async {
    try {
      singleton.order = newOrder;
      await WallpaperApp.prefs
          .setString(WallpaperApp.orderPref, newOrder.toString());
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void changeOrientation(WallpaperOrientation newOrientation) async {
    try {
      singleton.wallpaperOrientation = newOrientation;
      await WallpaperApp.prefs
          .setString(WallpaperApp.orientationPref, newOrientation.toString());
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void changeSafeSearch() async {
    try {
      singleton.safeSearch = !singleton.safeSearch;
      await WallpaperApp.prefs
          .setBool(WallpaperApp.safeSearchPref, singleton.safeSearch);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
