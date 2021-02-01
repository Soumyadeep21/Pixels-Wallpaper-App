import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:wallpaper_app/config/dark_mode.dart';
import 'package:wallpaper_app/pages/home_page.dart';
import 'package:wallpaper_app/pages/settings_page.dart';
import 'package:wallpaper_app/widgets/background.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentIndex = 0;
  PageController pageController;

  RateMyApp _rateMyApp = RateMyApp(
    googlePlayIdentifier: 'com.soumyadeep.pixels',
    minDays: 1,
    minLaunches: 5,
    remindDays: 5,
    remindLaunches: 10,
    preferencesPrefix: 'feedback',
  );

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    pageController.addListener(handleTabChange);
    showRatings();
  }

  void showRatings() {
    _rateMyApp.init().then((_) {
      if (_rateMyApp.shouldOpenDialog) {
        _rateMyApp.showRateDialog(
          context,
          title: 'Rate this app',
          message:
              'If you like this app, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.',
          rateButton: 'RATE',
          noButton: 'NO THANKS',
          laterButton: 'MAYBE LATER',
        );
      }
    });
  }

  void handleTabChange() {
    setState(() {
      currentIndex = pageController.page.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<DarkMode>(context).isDarkModeOn;
    return Background(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        body: PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomePage(),
            SettingsPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          },
          currentIndex: currentIndex,
          elevation: 0,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home_${isDark ? 'dark' : 'light'}.svg',
                height: 25,
                color: Color(0xffA5A6AC),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/home_${isDark ? 'dark' : 'light'}.svg',
                height: 25,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/settings_${isDark ? 'dark' : 'light'}.svg',
                height: 25,
                color: Color(0xffA5A6AC),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/settings_${isDark ? 'dark' : 'light'}.svg',
                height: 25,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
