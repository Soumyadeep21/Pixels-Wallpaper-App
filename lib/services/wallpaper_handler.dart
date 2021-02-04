import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_app/config/dark_mode.dart';
import 'package:wallpaper_app/models/wallpaper.dart';
import 'package:wallpaper_app/utils/constants.dart';
import 'package:wallpaper_app/widgets/wallpaper_button.dart';

class WallpaperHandler {
  static void showWallpaperInfo(BuildContext context, Wallpaper wallpaper) {
    bool isDark = Provider.of<DarkMode>(context, listen: false).isDarkModeOn;
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            gradient: isDark ? kDarkGradient : kLightGradient,
          ),
          height: 225,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text('Photo By'),
                  subtitle: Text('Pixabay'),
                ),
                ListTile(
                  title: Text(
                    'Photo Page URL',
                  ),
                  subtitle: Text(
                    wallpaper.pageURL,
                    style: TextStyle(
                      color: isDark ? kButtonDark : kButtonLight,
                    ),
                  ),
                  onTap: () async {
                    if (await canLaunch(wallpaper.pageURL)) {
                      await launch(wallpaper.pageURL);
                    } else {
                      throw 'Could not launch ${wallpaper.pageURL}';
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<String> downloadWallpaper(
    Wallpaper wallpaper, {
    bool isApply = false,
  }) async {
    var path =
        (await getExternalStorageDirectory()).parent.parent.parent.parent.path;
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission != PermissionStatus.granted) {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.storage]);
      if (permissions[PermissionGroup.storage] != PermissionStatus.granted) {
        Fluttertoast.showToast(
            msg: 'Download Failed! Storage Permissions should be granted');
        return '';
      }
    }
    // Directory downloadPath = Directory('/storage/emulated/0/.PixelsWallpapers');
    // downloadPath.exists().then((exist) async {
    //   if (!exist) await downloadPath.create();
    // });
    var filePath = '$path/Pixels Wallpapers/${wallpaper.id}.jpg';
    bool isDownloaded = await File(filePath).exists();
    if (isDownloaded) {
      if (!isApply)
        Fluttertoast.showToast(msg: 'Wallpaper is already downloaded!');
      return filePath;
    }
    Dio dio = Dio();
    try {
      await dio.download(wallpaper.largeImageURL, filePath);
      print('Download Complete');
      Fluttertoast.showToast(msg: 'Download Complete');
      return filePath;
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: 'Download Failed');
      return '';
    }
  }

  static Future<String> showSetWallpaper(BuildContext context) async {
    bool isDark = Provider.of<DarkMode>(context, listen: false).isDarkModeOn;
    double iconSize = 30;
    String value = await showModalBottomSheet<String>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            gradient: isDark ? kDarkGradient : kLightGradient,
          ),
          height: 250,
          child: Column(
            children: [
              Divider(color: Colors.transparent),
              Text(
                'Set Wallpaper',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      WallpaperButton(
                        onPressed: () {
                          Navigator.pop(context, 'HomeScreen');
                        },
                        color: isDark ? kDarkBackground : kLightBackground,
                        padding: 16,
                        child: Icon(
                          Icons.home_outlined,
                          size: iconSize,
                          color: isDark ? kButtonDark : kButtonLight,
                        ),
                      ),
                      Divider(color: Colors.transparent),
                      Text(
                        'Home Screen',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      WallpaperButton(
                        onPressed: () {
                          Navigator.pop(context, 'LockScreen');
                        },
                        color: isDark ? kDarkBackground : kLightBackground,
                        padding: 16,
                        child: Icon(
                          Icons.lock_outline,
                          size: iconSize,
                          color: isDark ? kButtonDark : kButtonLight,
                        ),
                      ),
                      Divider(color: Colors.transparent),
                      Text(
                        'Lock Screen',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      WallpaperButton(
                        onPressed: () {
                          Navigator.pop(context, 'Both');
                        },
                        color: isDark ? kDarkBackground : kLightBackground,
                        padding: 16,
                        child: Icon(
                          Icons.phone_android,
                          size: iconSize,
                          color: isDark ? kButtonDark : kButtonLight,
                        ),
                      ),
                      Divider(color: Colors.transparent),
                      Text(
                        'Both',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        );
      },
    );
    return value;
  }

  static Future<void> setWallpaper(String path, String type) async {
    final _platform = const MethodChannel('wallpaper');
    String message = await _platform.invokeMethod(type, path);
    Fluttertoast.showToast(msg: message);
  }
}
