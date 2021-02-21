import 'package:flutter/material.dart';
import 'package:wallpaper_app/widgets/search_wallpaper_field.dart';
import 'package:wallpaper_app/widgets/wallpaper_fetcher_widget.dart';
import 'package:wallpaper_app/utils/constants.dart';
import 'package:wallpaper_app/widgets/background.dart';

class SearchPage extends StatefulWidget {
  final String search;

  const SearchPage({Key key, this.search}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState(search);
}

class _SearchPageState extends State<SearchPage> {
  String search;

  _SearchPageState(this.search);
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SearchWallpaperField(
                initialValue: search,
                onSubmitted: (val) {
                  if (val == null || val == search) return;
                  setState(() {
                    print(val);
                    search = val;
                  });
                },
              ),
              Divider(color: Colors.transparent),
              Expanded(
                key: Key(search),
                child: WallpaperFetcherWidget(query: search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
