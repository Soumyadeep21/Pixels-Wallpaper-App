import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper_app/models/wallpaper.dart';
import 'package:wallpaper_app/services/wallpaper_service.dart';
import 'package:wallpaper_app/widgets/wallpaper_card.dart';

class EditorsPreview extends StatefulWidget {
  @override
  _EditorsPreviewState createState() => _EditorsPreviewState();
}

class _EditorsPreviewState extends State<EditorsPreview>
    with AutomaticKeepAliveClientMixin {
  WallpaperService wallpaperService;

  @override
  void initState() {
    super.initState();
    wallpaperService = WallpaperService(editorsChoice: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<List<Wallpaper>>(
      stream: wallpaperService.wallpaperStream,
      key: PageStorageKey('Editor'),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: ListView.separated(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(right: 16),
              physics: BouncingScrollPhysics(),
              separatorBuilder: (context, index) => VerticalDivider(
                color: Colors.transparent,
              ),
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(15),
                ),
                width: 127,
              ),
            ),
          );
        }
        return ListView.separated(
          itemCount: snapshot.data.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(right: 16),
          physics: BouncingScrollPhysics(),
          separatorBuilder: (context, index) => VerticalDivider(
            color: Colors.transparent,
          ),
          itemBuilder: (context, index) => WallpaperCard(
            wallpaper: snapshot.data[index],
            width: 127,
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}