import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:wallpaper_app/config/dark_mode.dart';
import 'package:wallpaper_app/models/wallpaper_response.dart';
import 'package:wallpaper_app/utils/wallpaper_handler.dart';

class FullImagePage extends StatelessWidget {
  final Wallpaper wallpaper;

  const FullImagePage({this.wallpaper});
  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = Provider.of<DarkMode>(context).isDarkModeOn;
    return Scaffold(
      backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
      body: Center(
        child: Hero(
          tag: wallpaper.largeImageURL,
          child: CachedNetworkImage(
            placeholder: (_, name) => SpinKitCubeGrid(
              color: isDarkModeOn ? Colors.white : Colors.blue,
            ),
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
                WallpaperHandler.downloadFile(wallpaper: wallpaper);
              },
              icon: Icon(Icons.file_download),
            ),
            IconButton(
              tooltip: 'Set Wallpaper',
              onPressed: () {
                WallpaperHandler.setWallpaper(
                    ctx: context,
                    isDarkModeOn: isDarkModeOn,
                    wallpaper: wallpaper);
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
                WallpaperHandler.showAboutDialog(
                    context, isDarkModeOn, wallpaper);
              },
              icon: Icon(Icons.info),
            ),
          ],
        ),
      ),
    );
  }
}
