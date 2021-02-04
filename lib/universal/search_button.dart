// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wallpaper_app/config/dark_mode.dart';

// class SearchButton extends StatelessWidget {
//   final Function onPressed;

//   const SearchButton({@required this.onPressed});
//   @override
//   Widget build(BuildContext context) {
//     bool isDarkModeOn = Provider.of<DarkMode>(context).isDarkModeOn;
//     return GestureDetector(
//       onTap: onPressed,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(30),
//         child: Container(
//           padding: EdgeInsets.all(8.0),
//           width: MediaQuery.of(context).size.width * .8,
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   colors: isDarkModeOn
//                       ? [Color(0xff56ab2f), Color(0xffa8e063)]
//                       : [Color(0xff2193b0), Color(0xff6dd5ed)],
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight)),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Icon(
//                 Icons.search,
//                 size: MediaQuery.of(context).size.width / 12,
//               ),
//               VerticalDivider(),
//               Text(
//                 'Search',
//                 style:
//                     TextStyle(fontSize: MediaQuery.of(context).size.width / 20),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
