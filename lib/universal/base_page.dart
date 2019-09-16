import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/config/base_page_config.dart';
import 'package:wallpaper_app/config/dark_mode.dart';
import 'package:wallpaper_app/universal/wallpaper_item.dart';
import 'package:wallpaper_app/utils/wallpaper_app.dart';

class BasePage extends StatelessWidget {

  final BasePageConfig config;

  const BasePage({Key key, @required this.config});

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) config.getMoreData();
    });
    bool isDarkModeOn = Provider.of<DarkMode>(context).isDarkModeOn;
    config.getData();
    return Column(
      children: <Widget>[
        Expanded(
          child: config.state == ViewState.Idle ||
                  config.state == ViewState.MoreDataLoading
              ? GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0),
                  itemCount: config.wallpaperList.length,
                  controller: _scrollController,
                  itemBuilder: (_, index) => WallpaperItem(wallpaper: config.wallpaperList[index], isDarkModeOn: isDarkModeOn),
                )
              : config.state == ViewState.Error
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(config.errorMessage),
                          RaisedButton(
                            child: Text('Retry'),
                            color: isDarkModeOn ? Colors.green : Colors.blue,
                            onPressed: () => config.reloadData(),
                          )
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
        ),
        Visibility(
          child: LinearProgressIndicator(),
          visible: config.state == ViewState.MoreDataLoading,
        ),
      ],
    );
  }
}