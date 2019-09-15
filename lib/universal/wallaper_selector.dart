import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wallpaper_app/universal/dialog_menu_item.dart';

class WallpaperSelector{
  static Future<String> showWallpaperSelectionDialog<String>({BuildContext context,bool isDarkModeOn}) async{
    var type = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        backgroundColor: isDarkModeOn ? Colors.black54 : Colors.white70,
        title: Text('Set Wallpaper'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        children: <Widget>[
          Divider(color: Colors.transparent,),
          DialogMenuItem(
            icon: FontAwesomeIcons.home,
            color: isDarkModeOn ? Colors.green : Colors.blue,
            text: 'Home Screen',
            onPressed: () => Navigator.pop(context,'HomeScreen'),
          ),
          Divider(color: Colors.transparent,),
          DialogMenuItem(
            icon: FontAwesomeIcons.lock,
            color: isDarkModeOn ? Colors.green : Colors.blue,
            text: 'Lock Screen',
            onPressed: () => Navigator.pop(context,'LockScreen'),
          ),
          Divider(color: Colors.transparent,),
          DialogMenuItem(
            icon: FontAwesomeIcons.mobileAlt,
            color: isDarkModeOn ? Colors.green : Colors.blue,
            text: 'Both',
            onPressed: () => Navigator.pop(context,'Both'),
          ),
        ],
      ),
    );
    return type;
  }
}