import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:wallpaper_app/config/dark_mode.dart';
import 'package:wallpaper_app/config/preferences.dart';
import 'package:wallpaper_app/utils/constants.dart';
import 'package:wallpaper_app/utils/wallpaper_app.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DarkMode darkMode = Provider.of<DarkMode>(context);
    Preferences preferences = Provider.of<Preferences>(context);
    Color iconColor = darkMode.isDarkModeOn ? Colors.white : Colors.black;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Text(
                'Settings',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0.0),
                leading: SvgPicture.asset(
                  'assets/icons/dark_mode.svg',
                  height: 25,
                  color: iconColor,
                ),
                title: Text('Enable Dark Mode'),
                trailing: CupertinoSwitch(
                  value: darkMode.isDarkModeOn,
                  activeColor: kButtonDark,
                  onChanged: (_) => darkMode.changeTheme(),
                ),
              ),
              Divider(),
              ListTile(
                contentPadding: EdgeInsets.all(0.0),
                leading: SvgPicture.asset(
                  'assets/icons/sort.svg',
                  height: 25,
                  color: iconColor,
                ),
                title: Text('Sort Images'),
                trailing: DropdownButton<Order>(
                  value: preferences.order,
                  onChanged: (value) => preferences.changeOrder(value),
                  underline: Container(),
                  items: [
                    DropdownMenuItem(
                      child: Text('Popular'),
                      value: Order.popular,
                    ),
                    DropdownMenuItem(
                      child: Text('Latest'),
                      value: Order.latest,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                contentPadding: EdgeInsets.all(0.0),
                leading: SvgPicture.asset(
                  'assets/icons/orientation.svg',
                  height: 25,
                  color: iconColor,
                ),
                title: Text('Image Orientation'),
                trailing: DropdownButton<WallpaperOrientation>(
                  value: preferences.wallpaperOrientation,
                  onChanged: (value) => preferences.changeOrientation(value),
                  underline: Container(),
                  items: [
                    DropdownMenuItem(
                      child: Text('All'),
                      value: WallpaperOrientation.all,
                    ),
                    DropdownMenuItem(
                      child: Text('Portrait'),
                      value: WallpaperOrientation.vertical,
                    ),
                    DropdownMenuItem(
                      child: Text('Landscape'),
                      value: WallpaperOrientation.horizontal,
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                contentPadding: EdgeInsets.all(0.0),
                leading: SvgPicture.asset(
                  'assets/icons/share.svg',
                  height: 25,
                  color: iconColor,
                ),
                title: Text('Tell a Friend'),
                onTap: () {
                  Share.share(
                      'https://play.google.com/store/apps/details?id=com.soumyadeep.pixels');
                },
              ),
              Divider(),
              ListTile(
                contentPadding: EdgeInsets.all(0.0),
                leading: SvgPicture.asset(
                  'assets/icons/feedback.svg',
                  height: 25,
                  color: iconColor,
                ),
                title: Text('Give Feedback'),
                onTap: () =>
                    LaunchReview.launch(androidAppId: "com.soumyadeep.pixels"),
              ),
              Divider(),
              ListTile(
                contentPadding: EdgeInsets.all(0.0),
                leading: SvgPicture.asset(
                  'assets/icons/about.svg',
                  height: 25,
                  color: iconColor,
                ),
                title: Text('About Us'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => SimpleDialog(
                      backgroundColor:
                          darkMode.isDarkModeOn ? Colors.black : Colors.white,
                      title: Text('About'),
                      children: <Widget>[
                        ListTile(
                          title: Text(WallpaperApp.appName),
                          subtitle: Text(WallpaperApp.appVersion),
                          trailing: Image.asset('assets/images/logo.png'),
                        ),
                        ListTile(
                          title: Text('Developed By'),
                          subtitle: Text('Soumyadeep Sinha'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ]),
            // crossAxisAlignment: CrossAxisAlignment.start,
            // children: ,
          ),
        ],
      ),
    );
  }
}
