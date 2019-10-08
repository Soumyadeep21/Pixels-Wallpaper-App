import 'package:flutter/material.dart';
import 'package:wallpaper_app/config/preferences.dart';
import 'package:wallpaper_app/utils/wallpaper_app.dart';

class URLMaker {
  static String url({
    String query,
    @required int page,
    bool editorsChoice,
  }) {
    String baseURL = 'https://pixabay.com/api/?key=${WallpaperApp.apiKey}';
    Preferences preferences = Preferences();
    bool safeSearch = preferences.safeSearch;
    WallpaperOrientation orientation = preferences.wallpaperOrientation;
    Order order = preferences.order;
    if (query != null) baseURL = baseURL + '&q=${_urlFormatter(query)}';
    if (safeSearch != null) baseURL = baseURL + '&safesearch=true';
    if (editorsChoice != null)
      baseURL = baseURL + '&editors_choice=$editorsChoice';
    baseURL = baseURL + '&page=$page';
    if (orientation != null)
      switch (orientation) {
        case WallpaperOrientation.all:
          baseURL = baseURL + '&orientation=all';
          break;
        case WallpaperOrientation.horizontal:
          baseURL = baseURL + '&orientation=horizontal';
          break;
        case WallpaperOrientation.vertical:
          baseURL = baseURL + '&orientation=vertical';
          break;
      }
    if (order != null)
      switch (order) {
        case Order.latest:
          baseURL = baseURL + '&order=latest';
          break;
        case Order.popular:
          baseURL = baseURL + '&order=popular';
          break;
      }
    return baseURL;
  }

  static String _urlFormatter(String txt) {
    txt.trim();
    txt.replaceAll(' ', '+');
    return txt;
  }
}
