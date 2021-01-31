import 'dart:async';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallpaper_app/models/wallpaper.dart';
import 'package:wallpaper_app/utils/constants.dart';

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
    try {
      var response = await _dio.get(
        'api/',
        queryParameters: _queries,
        options: buildCacheOptions(Duration(hours: 24)),
      );
      int totalHits = response.data['totalHits'];
      if (totalHits == null || totalHits == 0) {
        _controller.addError('No Wallpapers Found :(');
        return;
      }
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
        print(e.error);
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
      if (e.type == DioErrorType.RESPONSE) {
        Fluttertoast.showToast(msg: e.response.data.toString());
        return;
      }
      if (e.type == DioErrorType.DEFAULT) {
        print(e.error);
        return;
      }
    }
  }
}
