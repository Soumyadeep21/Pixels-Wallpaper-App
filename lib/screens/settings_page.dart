import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/config/dark_mode.dart';
import 'package:wallpaper_app/config/preferences.dart';
import 'package:wallpaper_app/utils/wallpaper_app.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var darkMode = Provider.of<DarkMode>(context);
    var preferences = Provider.of<Preferences>(context);
    return ListView(
      children: <Widget>[
        Divider(),
        ListTile(
          title: Text('Enable Dark Mode'),
          trailing: CupertinoSwitch(
            value: darkMode.isDarkModeOn,
            onChanged: (_) => darkMode.changeTheme(),
          ),
        ),
        Divider(),
        ListTile(
          title: Text('Safe Search'),
          subtitle: Text('Show only images that are suitable for all ages'),
          trailing: CupertinoSwitch(
            value: preferences.safeSearch,
            onChanged: (_) => preferences.changeSafeSearch(),
          ),
        ),
        Divider(),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom : 8.0),
            child: Text('Sort Images'),
          ),
          //subtitle: Text('Sort images by'),
          subtitle: CupertinoSegmentedControl(
            children: const <Order, Widget>{
              Order.popular: Text('Popular'),
              Order.latest: Text('Latest')
            },
            onValueChanged: (Order value) => preferences.changeOrder(value),
            groupValue: preferences.order,
            borderColor: darkMode.isDarkModeOn ? Colors.green : Colors.blue,
            selectedColor: darkMode.isDarkModeOn ? Colors.green : Colors.blue,
          ),
        ),
        Divider(),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('Image Orientation'),
          ),
          //subtitle: Text('Orientation of Wallpapers Shown'),
          subtitle: CupertinoSegmentedControl(
            children: const <WallpaperOrientation, Widget>{
              WallpaperOrientation.all: Text('All'),
              WallpaperOrientation.vertical: Text('Portrait'),
              WallpaperOrientation.horizontal: Text('Landscape'),
            },
            onValueChanged: (WallpaperOrientation value) =>
                preferences.changeOrientation(value),
            groupValue: preferences.wallpaperOrientation,
            borderColor: darkMode.isDarkModeOn ? Colors.green : Colors.blue,
            selectedColor: darkMode.isDarkModeOn ? Colors.green : Colors.blue,
          ),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.share),
          title: Text('Share'),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.info),
          title: Text('About'),
          onTap: () {},
        ),
        Divider()
      ],
    );
  }
}
