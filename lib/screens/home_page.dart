import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/config/dark_mode.dart';
import 'package:wallpaper_app/config/home_page_config.dart';
import 'package:wallpaper_app/universal/wallpaper_item.dart';
import 'package:wallpaper_app/utils/wallpaper_app.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController;
  HomePageConfig config;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) config.getMoreData();
    });
  }

  @override
  Widget build(BuildContext context) {
    config = Provider.of<HomePageConfig>(context);
    config.getData();
    bool isDarkModeOn = Provider.of<DarkMode>(context).isDarkModeOn;
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
