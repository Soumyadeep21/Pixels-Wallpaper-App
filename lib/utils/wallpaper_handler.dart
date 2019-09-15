import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_app/models/wallpaper_response.dart';
import 'package:wallpaper_app/universal/wallaper_selector.dart';

class WallpaperHandler{

  static const _platform = const MethodChannel('wallpaper');

  static Future<String> downloadFile({@required Wallpaper wallpaper}) async {
    var path = (await DownloadsPathProvider.downloadsDirectory).parent;
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
    Directory downloadPath = Directory('${path.path}/PixelsWallpaperDownloads');
    downloadPath.exists().then((exist) async {
      if (!exist) await downloadPath.create();
    });
    Dio dio = Dio();
    var filePath = '${downloadPath.path}/${wallpaper.id}.jpg';
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

  static void setWallpaper({@required BuildContext ctx, @required bool isDarkModeOn, @required Wallpaper wallpaper}) async {
    String type = await WallpaperSelector.showWallpaperSelectionDialog(
        context: ctx, isDarkModeOn: isDarkModeOn);
    if(type == null || type == '')
    return;
    await downloadFile(wallpaper: wallpaper).then((path) async {
      if (path == '') return;
      String message = await _platform.invokeMethod(type, path);
      Fluttertoast.showToast(msg: message);
    });
  }
}