import 'package:flutter/material.dart';
import 'package:wallpaper_app/utils/constants.dart';

class Background extends StatelessWidget {

  final Widget child;

  const Background({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: kLightGradient,
        ),
      child: child,
    );
  }
}