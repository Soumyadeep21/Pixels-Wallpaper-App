import 'package:flutter/material.dart';

class WallpaperButton extends StatelessWidget {
  const WallpaperButton({
    Key key,
    this.color,
    this.child,
    this.onPressed,
    this.padding = 20.0,
  }) : super(key: key);
  final Color color;
  final Widget child;
  final double padding;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: child,
      ),
    );
  }
}
