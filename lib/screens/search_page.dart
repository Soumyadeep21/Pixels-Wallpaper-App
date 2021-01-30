import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/config/search_page_config.dart';
import 'package:wallpaper_app/screens/full_search_page.dart';
import 'package:wallpaper_app/universal/search_button.dart';
import 'package:wallpaper_app/universal/search_text_field.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Divider(
            color: Colors.transparent,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(FontAwesomeIcons.search),
              Text(
                'Search As You Like It',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 15),
              ),
            ],
          ),
          Spacer(),
          Hero(
            tag: 'search',
            child: SearchTextField(
              controller: controller,
              onSubmitted: searchForWallpapers,
            ),
          ),
          Divider(
            color: Colors.transparent,
          ),
          Divider(
            color: Colors.transparent,
          ),
          SearchButton(
            onPressed: () => searchForWallpapers(controller.text),
          ),
          Spacer()
        ],
      ),
    );
  }

  void searchForWallpapers(String query) {
    print('Hello');
    print(query);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<SearchPageConfig>(
          create: (_) => SearchPageConfig(),
          child: FullSearchPage(
            controller: controller,
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
