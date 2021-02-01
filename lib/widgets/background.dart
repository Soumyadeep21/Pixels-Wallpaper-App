import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/config/dark_mode.dart';
import 'package:wallpaper_app/utils/constants.dart';

class Background extends StatelessWidget {

  final Widget child;

  const Background({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<DarkMode>(context).isDarkModeOn;
    return Container(
      decoration: BoxDecoration(
          gradient: isDark ? kDarkGradient : kLightGradient,
        ),
      child: child,
    );
  }
}