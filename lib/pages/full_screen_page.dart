import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/config/dark_mode.dart';
import 'package:wallpaper_app/models/wallpaper.dart';
import 'package:wallpaper_app/services/wallpaper_handler.dart';
import 'package:wallpaper_app/utils/constants.dart';
import 'package:wallpaper_app/widgets/wallpaper_button.dart';

class FullScreenPage extends StatelessWidget {
  final Wallpaper wallpaper;
  final UniqueKey heroTag;
  FullScreenPage(this.wallpaper, {this.heroTag});
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
                    onPressed: () {},
                    color: Colors.grey.withOpacity(0.5),
                    child: SvgPicture.asset(
                      'assets/icons/save.svg',
                      color: Colors.white,
                      height: 25,
                      width: 25,
                    ),
                  ),
                  WallpaperButton(
                    onPressed: () async{
                      String value = await WallpaperHandler.showSetWallpaper(context);
                      if(value == null || value.isEmpty) return;
                      //TODO: Apply Wallpaper
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
        ],
      ),
    );
  }
}
