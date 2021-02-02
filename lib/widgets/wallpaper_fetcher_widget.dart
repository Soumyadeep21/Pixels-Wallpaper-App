import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper_app/config/dark_mode.dart';
import 'package:wallpaper_app/models/wallpaper.dart';
import 'package:wallpaper_app/services/wallpaper_service.dart';
import 'package:wallpaper_app/utils/constants.dart';
import 'package:wallpaper_app/widgets/wallpaper_card.dart';

class WallpaperFetcherWidget extends StatefulWidget {
  final String query, color, category;
  final bool editorsChoice;

  const WallpaperFetcherWidget(
      {this.query, this.color, this.category, this.editorsChoice});
  @override
  _WallpaperFetcherWidgetState createState() => _WallpaperFetcherWidgetState();
}

class _WallpaperFetcherWidgetState extends State<WallpaperFetcherWidget> {
  WallpaperService wallpaperService;
  ScrollController _scrollController = ScrollController();
  bool isMoreLoading = false;

  @override
  void initState() {
    super.initState();
    wallpaperService = WallpaperService(
      category: widget.category,
      color: widget.color,
      editorsChoice: widget.editorsChoice,
      search: widget.query,
    );
    _scrollController.addListener(fetchMore);
  }

  void fetchMore() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        isMoreLoading = true;
      });
      try {
        await wallpaperService.fetchMore();
      } finally {
        setState(() {
          isMoreLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<DarkMode>(context).isDarkModeOn;
    Color iconColor = isDark ? Colors.white : Colors.black;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Wallpaper>>(
              stream: wallpaperService.wallpaperStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/error.svg',
                            height: 50,
                            color: iconColor,
                          ),
                          VerticalDivider(color: Colors.transparent),
                          Expanded(
                            child: Text(
                              snapshot.error ?? 'Some Error Occurred :(',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      RaisedButton(
                        onPressed: () {
                          wallpaperService.fetch(
                            category: widget.category,
                            color: widget.color,
                            editorsChoice: widget.editorsChoice,
                            search: widget.query,
                          );
                        },
                        color: isDark ? kButtonDark : kButtonLight,
                        child: Text('Retry'),
                      ),
                    ],
                  );
                }

                if (snapshot.connectionState != ConnectionState.active)
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: StaggeredGridView.countBuilder(
                      primary: false,
                      crossAxisCount: 4,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          height: index == 0 ? 250 : 300,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        );
                      },
                      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                    ),
                  );

                if (snapshot.data.isEmpty)
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/empty.svg',
                        height: 80,
                        color: iconColor,
                      ),
                      VerticalDivider(color: Colors.transparent),
                      Expanded(
                        child: Text(
                          'No Wallpapers Found :(',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  );

                return RefreshIndicator(
                  onRefresh: () async {
                    await wallpaperService.fetch(
                      category: widget.category,
                      color: widget.color,
                      editorsChoice: widget.editorsChoice,
                      search: widget.query,
                    );
                  },
                  child: StaggeredGridView.countBuilder(
                    primary: false,
                    crossAxisCount: 4,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    itemCount: snapshot.data.length,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      Wallpaper wallpaper = snapshot.data[index];
                      return WallpaperCard(
                        wallpaper: wallpaper,
                        isFirst: index == 0,
                      );
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                  ),
                );
              },
            ),
          ),
          if (isMoreLoading)
            LinearProgressIndicator(
              backgroundColor: isDark ? Color(0xFFc4e0e5) : Color(0xFFb06ab3),
              valueColor: new AlwaysStoppedAnimation<Color>(
                isDark ? kButtonDark : kButtonLight,
              ),
            ),
        ],
      ),
    );
  }
}
