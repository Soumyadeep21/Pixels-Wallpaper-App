import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wallpaper_app/screens/editors_choice_page.dart';
import 'package:wallpaper_app/screens/home_page.dart';
import 'package:wallpaper_app/screens/search_page.dart';
import 'package:wallpaper_app/screens/settings_page.dart';

class PageHandler {
  static List<Widget> pages = <Widget>[
    EditorsChoicePage(),
    HomePage(),
    SearchPage(),
    SettingsPage(),
  ];

  static List<BottomNavigationBarItem> getNavBarItems(bool isDarkModeOn) => [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.star),
          label: 'Editor\'s Choice',
          backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
          backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
          backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
        ),
      ];
}
