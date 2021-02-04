import 'dart:async';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallpaper_app/config/preferences.dart';
import 'package:wallpaper_app/models/wallpaper.dart';
import 'package:wallpaper_app/utils/constants.dart';
import 'package:wallpaper_app/utils/wallpaper_app.dart';

class WallpaperService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: kBaseUrl,
      queryParameters: {
        'key': kApiKey,
        'safesearch': true,
      },
    ),
  )..interceptors
      .add(DioCacheManager(CacheConfig(baseUrl: kBaseUrl)).interceptor);

  List<Wallpaper> _wallpapers = [];
  int _page = 1;
  Map<String, dynamic> _queries = {};
  StreamController<List<Wallpaper>> _controller = StreamController.broadcast();

  Stream<List<Wallpaper>> get wallpaperStream => _controller.stream;

  WallpaperService({
    String search,
    String category,
    String color,
    bool editorsChoice,
  }) {
    fetch(
      search: search,
      category: category,
      color: color,
      editorsChoice: editorsChoice,
    );
  }

  Future<void> fetch({
    String search,
    String category,
    String color,
    bool editorsChoice = false,
  }) async {
    _wallpapers = [];
    _queries = {};
    _page = 1;
    if (search != null) _queries['q'] = search;
    if (category != null) _queries['category'] = category.toLowerCase();
    if (color != null) _queries['colors'] = color.toLowerCase();
    _queries['editors_choice'] = editorsChoice;
    _queries['page'] = _page;
    // Setting up the preferences
    _setPreferences();

    try {
      var response = await _dio.get(
        'api/',
        queryParameters: _queries,
        options: buildCacheOptions(Duration(hours: 24)),
      );
      // int totalHits = response.data['totalHits'];
      // if (totalHits == null || totalHits == 0) {
      //   _controller.addError('No Wallpapers Found :(');
      //   return;
      // }
      response.data['hits'].forEach((val) {
        _wallpapers.add(Wallpaper.fromJSON(val));
      });
      _controller.add(_wallpapers);
    } on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE) {
        _controller.addError(e.response.data.toString());
        return;
      }
      if (e.type == DioErrorType.DEFAULT) {
        _controller.addError(
            'Unable to Fetch Wallpapers. Please Check your Internet Connection !');
        return;
      }
    }
  }

  Future<void> fetchMore() async {
    _page++;
    _queries['page'] = _page;
    try {
      var response = await _dio.get(
        'api/',
        queryParameters: _queries,
        options: buildCacheOptions(Duration(hours: 24)),
      );
      int totalHits = response.data['totalHits'];
      if (totalHits == null ||
          totalHits == 0 ||
          response.data['hits'].isEmpty) {
        Fluttertoast.showToast(msg: 'No More Wallpapers Found :(');
        return;
      }
      response.data['hits'].forEach((val) {
        _wallpapers.add(Wallpaper.fromJSON(val));
      });
      _controller.add(_wallpapers);
    } on DioError catch (e) {
      _page--;
      if (e.type == DioErrorType.RESPONSE) {
        Fluttertoast.showToast(msg: e.response.data.toString());
        return;
      }
      if (e.type == DioErrorType.DEFAULT) {
        print(e.error);
        Fluttertoast.showToast(
          msg:
              'Unable to Fetch Wallpapers. Please Check your Internet Connection !',
        );
        return;
      }
    }
  }

  void _setPreferences() {
    Preferences preferences = Preferences();
    WallpaperOrientation orientation = preferences.wallpaperOrientation;
    Order order = preferences.order;
    if (orientation != null)
      switch (orientation) {
        case WallpaperOrientation.all:
          _queries['orientation'] = 'all';
          break;
        case WallpaperOrientation.horizontal:
          _queries['orientation'] = 'horizontal';
          break;
        case WallpaperOrientation.vertical:
          _queries['orientation'] = 'vertical';
          break;
      }
    if (order != null)
      switch (order) {
        case Order.latest:
          _queries['order'] = 'latest';
          break;
        case Order.popular:
          _queries['order'] = 'popular';
          break;
      }
  }
}
