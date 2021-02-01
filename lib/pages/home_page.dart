import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/config/dark_mode.dart';
import 'package:wallpaper_app/pages/editors_page.dart';
import 'package:wallpaper_app/pages/search_page.dart';
import 'package:wallpaper_app/utils/constants.dart';
import 'package:wallpaper_app/widgets/category_card.dart';
import 'package:wallpaper_app/widgets/color_view.dart';
import 'package:wallpaper_app/widgets/editors_preview.dart';
import 'package:wallpaper_app/widgets/search_wallpaper_field.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<DarkMode>(context).isDarkModeOn;
    return Padding(
      padding: EdgeInsets.only(left: kDefaultPadding,),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(right: kDefaultPadding),
                  child: SearchWallpaperField(
                    clearOnSearch: true,
                    onSubmitted: (val) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SearchPage(
                            search: val,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Editor\'s Choice',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => EditorsPage(),
                            ),
                          );
                        },
                        child: Text(
                          'See All',
                          style: TextStyle(
                            color: isDark ? kButtonDark : kButtonLight,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.transparent),
                SizedBox(
                  height: 225,
                  child: EditorsPreview(),
                ),
                SizedBox(height: 32),
                Text(
                  'The color tone',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Divider(color: Colors.transparent),
                SizedBox(
                  height: 50,
                  child: ColorView(),
                ),
                SizedBox(height: 32),
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Divider(color: Colors.transparent),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(right: kDefaultPadding),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              childAspectRatio: 1.5,
              mainAxisSpacing: 8,
              children: kCategories
                  .map(
                    (e) => CategoryCard(
                      category: e,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
