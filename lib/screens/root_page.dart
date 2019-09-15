import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/config/dark_mode.dart';
import 'package:wallpaper_app/screens/editors_choice_page.dart';
import 'package:wallpaper_app/screens/home_page.dart';
import 'package:wallpaper_app/screens/settings_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  TabController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = TabController(initialIndex: 0, length: 4, vsync: this);
    _pageController.addListener(_handleTabChange);
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
        children: <Widget>[
          EditorsChoicePage(),
          HomePage(),
          Center(child: Text('🔥🔥🔥 Search Functionality Coming Soon 🔥🔥🔥',style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),),
          SettingsPage(),
        ],
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.star),
            title: Text('Editor\'s Choice'),
            backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
            backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
          ),
        ],
      ),
    );
  }
}
