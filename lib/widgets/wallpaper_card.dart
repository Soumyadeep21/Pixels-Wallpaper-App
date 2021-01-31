import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/wallpaper.dart';

class WallpaperCard extends StatelessWidget {
  const WallpaperCard({
    this.isFirst = false,
    @required this.wallpaper, this.width,

  });

  final Wallpaper wallpaper;
  final bool isFirst;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
