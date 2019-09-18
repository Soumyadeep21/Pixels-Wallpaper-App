import 'package:wallpaper_app/config/base_page_config.dart';

class SearchPageConfig extends BasePageConfig {
  Future<void> getData({bool editorsChoice,String query}) async => await super.getData(query: query);

  Future<void> getMoreData({bool editorsChoice,String query}) async => await super.getMoreData(query: query);

  Future<void> reloadData({bool editorsChoice,String query}) async => await super.reloadData(query: query);
}