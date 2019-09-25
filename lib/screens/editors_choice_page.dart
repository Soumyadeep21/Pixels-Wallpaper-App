import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/config/editors_choice_page_config.dart';
import 'package:wallpaper_app/universal/base_page.dart';

class EditorsChoicePage extends StatefulWidget {
  @override
  _EditorsChoicePageState createState() => _EditorsChoicePageState();
}

class _EditorsChoicePageState extends State<EditorsChoicePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    EditorsChoicePageConfig config =
        Provider.of<EditorsChoicePageConfig>(context);
    config.getData();
    return BasePage(
      config: config,
      appBarTitle: Row(
        children: <Widget>[Icon(Icons.star), Text('Editor\'s Choice')],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
