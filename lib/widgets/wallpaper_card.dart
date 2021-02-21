import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/wallpaper.dart';
import 'package:wallpaper_app/pages/full_screen_page.dart';

class WallpaperCard extends StatelessWidget {
  WallpaperCard({
    this.isFirst = false,
    @required this.wallpaper,
    this.width,
  });

  final Wallpaper wallpaper;
  final bool isFirst;
  final double width;
  final UniqueKey heroTag = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FullScreenPage(
            wallpaper,
            heroTag: heroTag,
          ),
        ));
      },
      child: Hero(
        tag: heroTag,
        child: Container(
          height: isFirst ? 250 : 300,
          width: width,
          // color: Colors.red,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: NetworkImage(wallpaper.webFormatURL),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
