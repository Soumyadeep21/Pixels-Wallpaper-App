// import 'dart:io';
// import 'package:dio/dio.dart';
// // import 'package:downloads_path_provider/downloads_path_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:wallpaper_app/models/wallpaper.dart';
// import 'package:wallpaper_app/universal/wallaper_selector.dart';

// class WallpaperHandler {
//   static const _platform = const MethodChannel('wallpaper');

//   static void showAboutDialog(context, bool isDarkModeOn, Wallpaper wallpaper) {
//     showDialog(
//         context: context,
//         builder: (context) => SimpleDialog(
//               title: Text('About'),
//               titlePadding: EdgeInsets.fromLTRB(12.0, 8.0, 4.0, 0.0),
//               contentPadding: EdgeInsets.symmetric(vertical: 4.0),
//               backgroundColor: isDarkModeOn ? Colors.black54 : Colors.white70,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0)),
//               children: <Widget>[
//                 ListTile(
//                   title: Text('Photo By'),
//                   subtitle: Text('Pixabay'),
//                 ),
//                 ListTile(
//                   title: Text('Size'),
//                   subtitle: Text('${_sizeInMB(wallpaper)} MB'),
//                 ),
//                 ListTile(
//                   title: Text(
//                     'Photo Page URL',
//                   ),
//                   subtitle: Text(wallpaper.pageURL,
//                       style: TextStyle(color: Colors.blue)),
//                   onTap: () async {
//                     if (await canLaunch(wallpaper.pageURL)) {
//                       await launch(wallpaper.pageURL);
//                     } else {
//                       throw 'Could not launch ${wallpaper.pageURL}';
//                     }
//                   },
//                 ),
//                 ListTile(
//                   title: Text('Photo Dimensions ( in Pixels )'),
//                   subtitle: Text(
//                       '${wallpaper.imageWidth} X ${wallpaper.imageHeight}'),
//                 )
//               ],
//             ));
//   }

//   static String _sizeInMB(Wallpaper wallpaper) {
//     String size = (wallpaper.imageSize / 1000000).toStringAsFixed(2);
//     return size;
//   }

//   static Future<String> downloadFile({@required Wallpaper wallpaper}) async {
//     //TODO: Implement the Downloads Folder
//     // var path = (await DownloadsPathProvider.downloadsDirectory).parent;
//     var path = '';
//     PermissionStatus permission = await PermissionHandler()
//         .checkPermissionStatus(PermissionGroup.storage);
//     if (permission != PermissionStatus.granted) {
//       Map<PermissionGroup, PermissionStatus> permissions =
//           await PermissionHandler()
//               .requestPermissions([PermissionGroup.storage]);
//       if (permissions[PermissionGroup.storage] != PermissionStatus.granted) {
//         Fluttertoast.showToast(
//             msg: 'Download Failed! Storage Permissions should be granted');
//         return '';
//       }
//     }
//     Directory downloadPath = Directory('$path/PixelsWallpaperDownloads');
//     downloadPath.exists().then((exist) async {
//       if (!exist) await downloadPath.create();
//     });
//     Dio dio = Dio();
//     var filePath = '${downloadPath.path}/${wallpaper.id}.jpg';
//     try {
//       await dio.download(wallpaper.largeImageURL, filePath);
//       print('Download Complete');
//       Fluttertoast.showToast(msg: 'Download Complete');
//       return filePath;
//     } catch (e) {
//       print(e);
//       Fluttertoast.showToast(msg: 'Download Failed');
//       return '';
//     }
//   }

//   static void setWallpaper(
//       {@required BuildContext ctx,
//       @required bool isDarkModeOn,
//       @required Wallpaper wallpaper}) async {
//     String type = await WallpaperSelector.showWallpaperSelectionDialog(
//         context: ctx, isDarkModeOn: isDarkModeOn);
//     if (type == null || type == '') return;
//     await downloadFile(wallpaper: wallpaper).then((path) async {
//       if (path == '') return;
//       String message = await _platform.invokeMethod(type, path);
//       Fluttertoast.showToast(msg: message);
//     });
//   }
// }
