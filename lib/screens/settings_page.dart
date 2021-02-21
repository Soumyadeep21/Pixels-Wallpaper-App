// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:launch_review/launch_review.dart';
// import 'package:provider/provider.dart';
// import 'package:share/share.dart';
// import 'package:wallpaper_app/config/dark_mode.dart';
// import 'package:wallpaper_app/config/preferences.dart';
// import 'package:wallpaper_app/utils/wallpaper_app.dart';

// class SettingsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var darkMode = Provider.of<DarkMode>(context);
//     var preferences = Provider.of<Preferences>(context);
//     return ListView(
//       children: <Widget>[
//         Divider(),
//         ListTile(
        
//           title: Text('Enable Dark Mode'),
//           trailing: CupertinoSwitch(
//             value: darkMode.isDarkModeOn,
//             onChanged: (_) => darkMode.changeTheme(),
//           ),
//         ),
//         Divider(),
//         // ListTile(
//         //   title: Text('Safe Search'),
//         //   subtitle: Text('Show only images that are suitable for all ages'),
//         //   trailing: CupertinoSwitch(
//         //     value: preferences.safeSearch,
//         //     onChanged: (_) => preferences.changeSafeSearch(),
//         //   ),
//         // ),
//         // Divider(),
//         ListTile(
//           title: Padding(
//             padding: const EdgeInsets.only(bottom: 8.0),
//             child: Text('Sort Images'),
//           ),
//           subtitle: CupertinoSegmentedControl(
//             children: const <Order, Widget>{
//               Order.popular: Text('Popular'),
//               Order.latest: Text('Latest')
//             },
//             onValueChanged: (Order value) => preferences.changeOrder(value),
//             groupValue: preferences.order,
//             borderColor: darkMode.isDarkModeOn ? Colors.green : Colors.blue,
//             selectedColor: darkMode.isDarkModeOn ? Colors.green : Colors.blue,
//           ),
//         ),
//         Divider(),
//         ListTile(
//           title: Padding(
//             padding: const EdgeInsets.only(bottom: 8.0),
//             child: Text('Image Orientation'),
//           ),
//           subtitle: CupertinoSegmentedControl(
//             children: const <WallpaperOrientation, Widget>{
//               WallpaperOrientation.all: Text('All'),
//               WallpaperOrientation.vertical: Text('Portrait'),
//               WallpaperOrientation.horizontal: Text('Landscape'),
//             },
//             onValueChanged: (WallpaperOrientation value) =>
//                 preferences.changeOrientation(value),
//             groupValue: preferences.wallpaperOrientation,
//             borderColor: darkMode.isDarkModeOn ? Colors.green : Colors.blue,
//             selectedColor: darkMode.isDarkModeOn ? Colors.green : Colors.blue,
//           ),
//         ),
//         Divider(),
//         ListTile(
//           leading: Icon(Icons.share),
//           title: Text('Share'),
//           onTap: () {
//             Share.share('https://play.google.com/store/apps/details?id=com.soumyadeep.pixels');
//           },
//         ),        
//         Divider(),
//         ListTile(
//           leading: Icon(Icons.stars),
//           title: Text('Give Feedback'),
//           onTap: () => LaunchReview.launch(androidAppId: "com.soumyadeep.pixels"),
//         ),
//         Divider(),
//         ListTile(
//           leading: Icon(Icons.info),
//           title: Text('About'),
//           onTap: () {
//             showDialog(
//               context: context,
//               builder: (ctx) => SimpleDialog(
//                 backgroundColor: darkMode.isDarkModeOn ? Colors.black : Colors.white,
//                 title: Text('About'),
//                 children: <Widget>[
//                   ListTile(
//                     title: Text(WallpaperApp.appName),
//                     subtitle: Text(WallpaperApp.appVersion),
//                     trailing: Image.asset('assets/images/logo.png'),
//                   ),
//                   ListTile(
//                     title: Text('Developed By'),
//                     subtitle: Text('Soumyadeep Sinha'),
//                   ),
//                 ],
//               )
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
