import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/config/editors_choice_page_config.dart';
import 'package:wallpaper_app/universal/base_page.dart';

class EditorsChoicePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    EditorsChoicePageConfig config = Provider.of<EditorsChoicePageConfig>(context);
    return BasePage(config: config);
  }
}