import 'package:wallpaper_app/config/base_page_config.dart';

class EditorsChoicePageConfig extends BasePageConfig {
  Future<void> getData() async =>
      await super.getWallpaperData(editorsChoice: true);

  Future<void> getMoreData() async =>
      await super.getMoreWallpaperData(editorsChoice: true);

  Future<void> reloadData() async =>
      await super.reloadWallpaperData(editorsChoice: true);
}
