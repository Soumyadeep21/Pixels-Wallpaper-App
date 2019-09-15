import 'package:wallpaper_app/config/base_page_config.dart';

class HomePageConfig extends BasePageConfig {
  Future<void> getData() async => await super.getWallpaperData();

  Future<void> getMoreData() async => await super.getMoreWallpaperData();

  Future<void> reloadData() async => await super.reloadWallpaperData();
}
