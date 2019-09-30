import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:wallpaper_app/config/dark_mode.dart';
import 'package:wallpaper_app/models/wallpaper_response.dart';
import 'package:wallpaper_app/utils/wallpaper_handler.dart';

class FullImagePage extends StatefulWidget {
  final List<Wallpaper> wallpaperList;
  final int selectedIndex;

  const FullImagePage({@required this.wallpaperList,@required this.selectedIndex});

  @override
  _FullImagePageState createState() => _FullImagePageState(wallpaperList,selectedIndex);
}

class _FullImagePageState extends State<FullImagePage> {


  @override
  void initState() {
    super.initState();
    wallpaper = wallpaperList[selectedIndex];
    pageController = PageController(
      initialPage: selectedIndex
    );
    pageController.addListener((){
      wallpaper = wallpaperList[pageController.page.toInt()];
    });
  }

  final List<Wallpaper> wallpaperList;
  final int selectedIndex;
  PageController pageController;
  Wallpaper wallpaper;

  _FullImagePageState(this.wallpaperList, this.selectedIndex);
  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = Provider.of<DarkMode>(context).isDarkModeOn;
    return Scaffold(
      backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
      body: PageView.builder(
        controller: pageController,
        itemCount: wallpaperList.length,
        itemBuilder: (_,index) => Center(
        child: CachedNetworkImage(
          placeholder: (_, name) => SpinKitCubeGrid(
            color: isDarkModeOn ? Colors.white : Colors.blue,
          ),
          imageUrl: wallpaperList[index].largeImageURL,
          fit: BoxFit.cover,
        ),
      ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: isDarkModeOn ? Colors.black : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              tooltip: 'Go Back',
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios),
            ),
            IconButton(
              tooltip: 'Download',
              onPressed: () {
                WallpaperHandler.downloadFile(wallpaper: wallpaper);
              },
              icon: Icon(Icons.file_download),
            ),
            IconButton(
              tooltip: 'Set Wallpaper',
              onPressed: () {
                WallpaperHandler.setWallpaper(
                    ctx: context,
                    isDarkModeOn: isDarkModeOn,
                    wallpaper: wallpaper);
              },
              icon: Icon(Icons.wallpaper),
            ),
            IconButton(
              tooltip: 'Share',
              onPressed: () {
                Share.share(wallpaper.largeImageURL);
              },
              icon: Icon(Icons.share),
            ),
            IconButton(
              tooltip: 'Image Info',
              onPressed: () {
                WallpaperHandler.showAboutDialog(
                    context, isDarkModeOn, wallpaper);
              },
              icon: Icon(Icons.info),
            ),
          ],
        ),
      ),
    );
  }
}
