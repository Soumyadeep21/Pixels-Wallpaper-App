// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:wallpaper_app/screens/full_image_page.dart';
// import 'package:wallpaper_app/models/wallpaper.dart';

// class WallpaperItem extends StatelessWidget {
//   const WallpaperItem({
//     Key key,
//     @required this.isDarkModeOn,
//     @required this.wallpaperList,
//     @required this.selectedIndex,
//   }) : super(key: key);

//   final List<Wallpaper> wallpaperList;
//   final int selectedIndex;
//   final bool isDarkModeOn;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Navigator.push(
//         context,
//         PageTransition(
//           type: PageTransitionType.fade,
//           duration: Duration(milliseconds: 430),
//           child: FullImagePage(
//             selectedIndex: selectedIndex,
//             wallpaperList: wallpaperList,
//           ),
//         )
//       ),
//       child: Material(
//         borderRadius: BorderRadius.circular(10.0),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10.0),
//           child: CachedNetworkImage(
//             placeholder: (_, name) => SpinKitCubeGrid(
//               color: isDarkModeOn ? Colors.white : Colors.blue,
//             ),
//             imageUrl: wallpaperList[selectedIndex].largeImageURL,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }
