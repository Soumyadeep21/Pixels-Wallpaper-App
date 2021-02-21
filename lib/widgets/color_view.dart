import 'package:flutter/material.dart';
import 'package:wallpaper_app/pages/color_page.dart';
import 'package:wallpaper_app/utils/constants.dart';

class ColorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      children: kSearchColors.keys
          .map((e) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ColorPage(
                        colorText: e,
                        color: kSearchColors[e],
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: e,
                  child: Container(
                    width: 50,
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: kSearchColors[e],
                      borderRadius: BorderRadiusDirectional.circular(15),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}