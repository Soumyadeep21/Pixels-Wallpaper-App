import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallpaper_app/models/wallpaper_response.dart';
import 'package:wallpaper_app/utils/url_maker.dart';
import 'package:wallpaper_app/utils/wallpaper_app.dart';
import 'package:http/http.dart' as http;

class BasePageConfig extends ChangeNotifier{
  BasePageConfig();
  ViewState _state = ViewState.Busy;
  int _page = 1;
  int _totalPages;
  String url, errorMessage;
  bool isDataLoaded = false;
  List<Wallpaper> wallpaperList = <Wallpaper>[];
  void _setState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> getData({bool editorsChoice,String query}) async {
    if (isDataLoaded) return;
    url = URLMaker.url(page: _page, editorsChoice: editorsChoice,query: query);
    try {
      print(url);
      final response = await http.get(url);
      print(response.body);
      if (response.statusCode == 200) {
        WallpaperResponse data = _wallpaperFromJson(response.body);
        wallpaperList.addAll(data.hits);
        _totalPages = (data.totalHits / 20).ceil();
        isDataLoaded = true;
      }
      else{
        errorMessage = 'Some Error Occurred . Status Code : ${response.statusCode} . Contact Developer';
        _setState(ViewState.Error);
      }
      _setState(ViewState.Idle);
    } on SocketException {
      errorMessage = 'No Internet Connection';
      _setState(ViewState.Error);
    }
  }

  Future<void> getMoreData({bool editorsChoice,String query}) async {
    if (_page == _totalPages) return;
    try {
      ++_page;
      url = URLMaker.url(page: _page, editorsChoice: editorsChoice,query: query);
      _setState(ViewState.MoreDataLoading);
      final response = await http.get(url);
      if(response.statusCode == 200){
        WallpaperResponse data = _wallpaperFromJson(response.body);
      wallpaperList.addAll(data.hits);
      _setState(ViewState.Idle);
      }else{
        _setState(ViewState.Idle);
        errorMessage =
            'Some Error Occurred . Status Code : ${response.statusCode} . Contact Developer';
            Fluttertoast.showToast(msg:errorMessage);
      }
      
    } on SocketException {
      _setState(ViewState.Idle);
      errorMessage = 'No Internet Connection';
      Fluttertoast.showToast(msg: errorMessage);
    }
  }

  Future<void> reloadData({bool editorsChoice,String query}) async {
    _setState(ViewState.Busy);
    _page = 1;
    errorMessage = '';
    wallpaperList = <Wallpaper>[];
    isDataLoaded = false;
    await getData(editorsChoice: editorsChoice,query: query);
  }

  WallpaperResponse _wallpaperFromJson(String str) {
    final jsonData = json.decode(str);
    return WallpaperResponse.fromJSON(jsonData);
  }

  ViewState get state => _state;
}