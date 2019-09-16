import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:wallpaper_app/config/dark_mode.dart';
import 'package:wallpaper_app/utils/page_handler.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  TabController _pageController;

  RateMyApp _rateMyApp = RateMyApp(
      minDays: 1,
      minLaunches: 5,
      remindDays: 5,
      remindLaunches: 10,
      preferencesPrefix: 'feedback');

  @override
  void initState() {
    super.initState();
    _pageController = TabController(
        initialIndex: 0, length: PageHandler.pages.length, vsync: this);
    _pageController.addListener(_handleTabChange);
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
          ignoreIOS: false,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    setState(() {
      _currentIndex = _pageController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = Provider.of<DarkMode>(context).isDarkModeOn;
    return Scaffold(
      backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
      body: TabBarView(
        controller: _pageController,
        children: PageHandler.pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        selectedItemColor: isDarkModeOn ? Colors.green : Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.index = _currentIndex;
          });
        },
        items: PageHandler.getNavBarItems(isDarkModeOn),
      ),
    );
  }
}
