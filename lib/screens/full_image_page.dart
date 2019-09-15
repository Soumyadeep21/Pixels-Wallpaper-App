import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_app/config/dark_mode.dart';
import 'package:wallpaper_app/networking/wallpaper_response.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';

class FullImagePage extends StatelessWidget {
  final Wallpaper wallpaper;
  static const platform = const MethodChannel('wallpaper');

  const FullImagePage({this.wallpaper});

  Future<String> downloadFile() async {
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

  void setWallpaper() async {
    await downloadFile().then((path) async {
      if (path == '') return;
      String message = await platform.invokeMethod('HomeScreen', path);
      Fluttertoast.showToast(msg: message);
    });
  }

  void _showAboutDialog(context, bool isDarkModeOn) {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: Text('About'),
              titlePadding: EdgeInsets.fromLTRB(12.0, 8.0, 4.0, 0.0),
              contentPadding: EdgeInsets.symmetric(vertical: 4.0),
              backgroundColor: isDarkModeOn ? Colors.black54 : Colors.white70,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              children: <Widget>[
                ListTile(
                  title: Text('Photo By'),
                  subtitle: Text('Pixabay'),
                ),
                ListTile(
                  title: Text('Size'),
                  subtitle: Text('${sizeInMB()} MB'),
                ),
                ListTile(
                  title: Text(
                    'Photo Page URL',
                  ),
                  subtitle: Text(wallpaper.pageURL,
                      style: TextStyle(color: Colors.blue)),
                  onTap: () async {
                    if (await canLaunch(wallpaper.pageURL)) {
                      await launch(wallpaper.pageURL);
                    } else {
                      throw 'Could not launch ${wallpaper.pageURL}';
                    }
                  },
                ),
                ListTile(
                  title: Text('Photo Dimensions ( in Pixels )'),
                  subtitle: Text(
                      '${wallpaper.imageWidth} X ${wallpaper.imageHeight}'),
                )
              ],
            ));
  }

  String sizeInMB() {
    String size = (wallpaper.imageSize / 1000000).toStringAsFixed(2);
    return size;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = Provider.of<DarkMode>(context).isDarkModeOn;
    return Scaffold(
      backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
      body: Center(
        child: Hero(
          tag: wallpaper.largeImageURL,
          child: CachedNetworkImage(
            imageUrl: wallpaper.largeImageURL,
            fit: BoxFit.cover,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: isDarkModeOn ? Colors.black : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              tooltip: 'Go Back',
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios),
            ),
            IconButton(
              tooltip: 'Download',
              onPressed: () {
                downloadFile();
              },
              icon: Icon(Icons.file_download),
            ),
            IconButton(
              tooltip: 'Set Wallpaper',
              onPressed: () {
                setWallpaper();
              },
              icon: Icon(Icons.wallpaper),
            ),
            IconButton(
              tooltip: 'Share',
              onPressed: () {
                Share.share(wallpaper.largeImageURL);
              },
              icon: Icon(Icons.share),
            ),
            IconButton(
              tooltip: 'Image Info',
              onPressed: () {
                _showAboutDialog(context, isDarkModeOn);
              },
              icon: Icon(Icons.info),
            ),
          ],
        ),
      ),
    );
  }
}
