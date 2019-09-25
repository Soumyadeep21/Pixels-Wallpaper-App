import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/config/base_page_config.dart';
import 'package:wallpaper_app/config/dark_mode.dart';
import 'package:wallpaper_app/universal/not_found_widget.dart';
import 'package:wallpaper_app/universal/wallpaper_error_widget.dart';
import 'package:wallpaper_app/universal/wallpaper_item.dart';
import 'package:wallpaper_app/utils/wallpaper_app.dart';

class BasePage extends StatelessWidget {
  final BasePageConfig config;
  final Widget appBarTitle;
  final bool isSearchPage;
  final Function searchFunction;

  const BasePage(
      {Key key,
      @required this.config,
      @required this.appBarTitle,
      this.isSearchPage,
      this.searchFunction});

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) config.getMoreData();
    });
    bool isDarkModeOn = Provider.of<DarkMode>(context).isDarkModeOn;
    return Material(
      color: isDarkModeOn ? Colors.black : Colors.white,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                controller: _scrollController,
                slivers: <Widget>[
                  SliverAppBar(
                    title: appBarTitle,
                    floating: true,
                    actions: <Widget>[
                      Visibility(
                        visible: isSearchPage ?? false,
                        child: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: searchFunction,
                        ),
                      ),
                      Visibility(
                        visible: !(isSearchPage ?? false),
                                              child: IconButton(
                          icon: Icon(Icons.replay),
                          onPressed: () {
                            _scrollController.jumpTo(0.0);
                            config.reloadData();
                          },
                        ),
                      )
                    ],
                  ),
                  config.state == ViewState.Idle ||
                          config.state == ViewState.MoreDataLoading
                      ? SliverGrid.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 3.0,
                          mainAxisSpacing: 3.0,
                          children: config.wallpaperList
                              .map(
                                (wallpaper) => WallpaperItem(
                                  wallpaper: wallpaper,
                                  isDarkModeOn: isDarkModeOn,
                                ),
                              )
                              .toList(),
                        )
                      : SliverFillRemaining(
                          child: config.state == ViewState.Error
                              ? WallpaperErrorWidget(
                                  config: config, isDarkModeOn: isDarkModeOn)
                              : config.state == ViewState.NotFound
                                  ? NotFoundWidget()
                                  : Center(
                                      child: SpinKitWanderingCubes(
                                        color: isDarkModeOn
                                            ? Colors.white
                                            : Colors.blue,
                                      ),
                                    ),
                        ),
                ],
              ),
            ),
          ),
          Visibility(
            child: LinearProgressIndicator(),
            visible: config.state == ViewState.MoreDataLoading,
          ),
        ],
      ),
    );
  }
}

