import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallpaper_app/utils/constants.dart';
import 'package:wallpaper_app/widgets/category_card.dart';
import 'package:wallpaper_app/widgets/color_view.dart';
import 'package:wallpaper_app/widgets/editors_preview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: kDefaultPadding),
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(right: kDefaultPadding),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: kLightBackground,
                      hintText: 'Find Wallpaper...',
                      hintStyle: TextStyle(color: Colors.black.withOpacity(.3)),
                      suffixIcon: IconButton(
                        icon: SvgPicture.asset(
                          'assets/icons/search.svg',
                          color: Colors.black.withOpacity(.3),
                        ),
                        onPressed: () {},
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  'Editor\'s Choice',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
