import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/widgets/wallpaper_fetcher_widget.dart';
import 'package:wallpaper_app/utils/constants.dart';
import 'package:wallpaper_app/widgets/background.dart';

class ColorPage extends StatelessWidget {
  final String colorText;
  final Color color;

  const ColorPage({
    Key key,
    @required this.colorText,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: colorText,
                                      child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadiusDirectional.circular(9),
                      ),
                    ),
                  ),
                  VerticalDivider(color: Colors.transparent),
                  Text(
                    colorText,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.transparent),
              Expanded(child: WallpaperFetcherWidget(color: colorText)),
            ],
          ),
        ),
      ),
    );
  }
}
