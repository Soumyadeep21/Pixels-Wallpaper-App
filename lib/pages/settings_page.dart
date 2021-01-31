import 'package:flutter/material.dart';
import 'package:wallpaper_app/utils/constants.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 28,
              ),
            ),
            Divider(color: Colors.transparent,),
          ],
        ),
      ),
    );
  }
}
