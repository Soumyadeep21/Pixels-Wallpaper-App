import 'package:flutter/material.dart';
import 'package:wallpaper_app/config/base_page_config.dart';

class WallpaperErrorWidget extends StatelessWidget {
  WallpaperErrorWidget({
    @required this.config,
    @required this.isDarkModeOn,
  });

  final BasePageConfig config;
  final bool isDarkModeOn;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(config.errorMessage),
          RaisedButton(
            child: Text('Retry'),
            color: isDarkModeOn ? Colors.green : Colors.blue,
            onPressed: () => config.reloadData(),
          )
        ],
      ),
    );
  }
}
