import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallpaper_app/models/wallpaper_response.dart';
import 'package:wallpaper_app/screens/full_image_page.dart';

class WallpaperItem extends StatelessWidget {
  const WallpaperItem({
    Key key,
    @required this.wallpaper,
    @required this.isDarkModeOn,
  }) : super(key: key);

  final Wallpaper wallpaper;
  final bool isDarkModeOn;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FullImagePage(
            wallpaper: wallpaper,
          ),
        ),
      ),
      child: Hero(
        tag: wallpaper.largeImageURL,
        child: Material(
          borderRadius: BorderRadius.circular(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              placeholder: (_, name) => SpinKitCubeGrid(
                color: isDarkModeOn ? Colors.white : Colors.blue,
              ),
              imageUrl: wallpaper.largeImageURL,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
