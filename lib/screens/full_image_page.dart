import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_app/config/dark_mode.dart';
import 'package:wallpaper_app/models/wallpaper_response.dart';
import 'package:wallpaper_app/utils/wallpaper_handler.dart';

class FullImagePage extends StatelessWidget {
  final Wallpaper wallpaper;

  const FullImagePage({this.wallpaper});

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
