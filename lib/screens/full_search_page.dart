// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wallpaper_app/config/search_page_config.dart';
// import 'package:wallpaper_app/universal/base_page.dart';
// import 'package:wallpaper_app/universal/search_text_field.dart';

// class FullSearchPage extends StatelessWidget {
//   final TextEditingController controller;

//   const FullSearchPage({this.controller});
//   @override
//   Widget build(BuildContext context) {
//     SearchPageConfig config = Provider.of<SearchPageConfig>(context);
//     config.getData(query: controller.text);
//     return BasePage(
//       config: config,
//       isSearchPage: true,
//       appBarTitle: Hero(
//         tag: 'search',
//         child: SearchTextField(
//           controller: controller,
//           onSubmitted: (txt) => config.reloadData(query: txt),
//         ),
//       ),
//       searchFunction: () => config.reloadData(query: controller.text),
//     );
//   }
// }
