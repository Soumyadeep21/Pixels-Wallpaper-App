import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/config/home_page_config.dart';
import 'package:wallpaper_app/universal/base_page.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    HomePageConfig config = Provider.of<HomePageConfig>(context);
    return BasePage(config: config);
  }
}
