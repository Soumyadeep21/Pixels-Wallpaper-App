import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/widgets/wallpaper_fetcher_widget.dart';
import 'package:wallpaper_app/utils/constants.dart';
import 'package:wallpaper_app/widgets/background.dart';

class CategoryPage extends StatelessWidget {
  final String category;

  const CategoryPage({Key key, @required this.category}) : super(key: key);

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                category,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
              ),
              Divider(color: Colors.transparent),
              Expanded(child: WallpaperFetcherWidget(category: category)),
            ],
          ),
        ),
      ),
    );
  }
}
