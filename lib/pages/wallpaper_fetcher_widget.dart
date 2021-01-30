import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/models/wallpaper.dart';
import 'package:wallpaper_app/services/wallpaper_service.dart';

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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Wallpaper>>(
              stream: wallpaperService.wallpaperStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.active) {
                  return Center(
                    child: SpinKitWanderingCubes(
                      color: Colors.blue,
                    ),
                  );
                }

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
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
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
          if (isMoreLoading) LinearProgressIndicator(),
        ],
      ),
    );
  }
}

class WallpaperCard extends StatelessWidget {
  const WallpaperCard({
    this.isFirst = false,
    @required this.wallpaper,
  });

  final Wallpaper wallpaper;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isFirst ? 250 : 300,
      // color: Colors.red,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(wallpaper.webFormatURL),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
