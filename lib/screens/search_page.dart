import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wallpaper_app/universal/search_text_field.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Divider(
            color: Colors.transparent,
          ),
          SearchTextField(
            controller: controller,
            onSubmitted: searchForWallpapers,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => searchForWallpapers(controller.text),
          )
        ],
      ),
    );
  }

  void searchForWallpapers(String query) {
    print('Hello');
    print(query);
  }
}
