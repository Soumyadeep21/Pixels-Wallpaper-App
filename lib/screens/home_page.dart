import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/config/dark_mode.dart';
import 'package:wallpaper_app/config/home_page_config.dart';
import 'package:wallpaper_app/screens/full_image_page.dart';
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
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FullImagePage(
                          wallpaper: config.wallpaperList[index],
                        ),
                      ),
                    ),
                    child: Hero(
                      tag: config.wallpaperList[index].largeImageURL,
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            placeholder: (_,name) => SpinKitCubeGrid(color: isDarkModeOn ? Colors.white : Colors.blue,),
                            imageUrl: config.wallpaperList[index].largeImageURL,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
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
