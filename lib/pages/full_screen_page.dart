import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/config/dark_mode.dart';
import 'package:wallpaper_app/models/wallpaper.dart';
import 'package:wallpaper_app/services/wallpaper_handler.dart';
import 'package:wallpaper_app/utils/constants.dart';
import 'package:wallpaper_app/widgets/wallpaper_button.dart';

class FullScreenPage extends StatefulWidget {
  final Wallpaper wallpaper;
  final UniqueKey heroTag;
  FullScreenPage(this.wallpaper, {this.heroTag});

  @override
  _FullScreenPageState createState() =>
      _FullScreenPageState(this.wallpaper, this.heroTag);
}

class _FullScreenPageState extends State<FullScreenPage> {
  bool isDownloading = false;
  final Wallpaper wallpaper;
  final UniqueKey heroTag;

  _FullScreenPageState(this.wallpaper, this.heroTag);

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<DarkMode>(context).isDarkModeOn;
    return Scaffold(
      body: Stack(
        children: [
          PhotoView(
            imageProvider: NetworkImage(wallpaper.webFormatURL),
            backgroundDecoration: BoxDecoration(
              gradient: isDark ? kDarkGradient : kLightGradient,
            ),
            initialScale: PhotoViewComputedScale.covered,
            minScale: PhotoViewComputedScale.covered,
            maxScale: PhotoViewComputedScale.covered,
            heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  WallpaperButton(
                    onPressed: () {
                      WallpaperHandler.showWallpaperInfo(context, wallpaper);
                    },
                    color: Colors.grey.withOpacity(0.5),
                    child: SvgPicture.asset(
                      'assets/icons/info.svg',
                      color: Colors.white,
                      height: 25,
                      width: 25,
                    ),
                  ),
                  WallpaperButton(
                    onPressed: () async {
                      setState(() {
                        isDownloading = true;
                      });
                      try {
                        await WallpaperHandler.downloadWallpaper(wallpaper);
                      } finally {
                        setState(() {
                          isDownloading = false;
                        });
                      }
                    },
                    color: Colors.grey.withOpacity(0.5),
                    child: SvgPicture.asset(
                      'assets/icons/save.svg',
                      color: Colors.white,
                      height: 25,
                      width: 25,
                    ),
                  ),
                  WallpaperButton(
                    onPressed: () async {
                      String type =
                          await WallpaperHandler.showSetWallpaper(context);
                      if (type == null || type.isEmpty) return;
                      setState(() {
                        isDownloading = true;
                      });
                      try {
                        String path = await WallpaperHandler.downloadWallpaper(
                          wallpaper,
                          isApply: true,
                        );
                        await WallpaperHandler.setWallpaper(path, type);
                      } finally {
                        setState(() {
                          isDownloading = false;
                        });
                      }
                    },
                    color: isDark ? kButtonDark : kButtonLight,
                    child: SvgPicture.asset(
                      'assets/icons/apply.svg',
                      color: Colors.white,
                      height: 25,
                      width: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isDownloading,
            child: Container(
              color: isDark ? Colors.black54 : Colors.white54,
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                        isDark ? kButtonDark : kButtonLight,
                      ),
                    ),
                    VerticalDivider(color: Colors.transparent),
                    Text(
                      'Please wait while its downloading :)',
                      style:
                          TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
