import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/services/dark_mode.dart';
import 'package:wallpaper_app/utils/constants.dart';

// ignore: must_be_immutable
class SearchWallpaperField extends StatelessWidget {
  final String initialValue;
  final void Function(String) onSubmitted;
  String value = '';
  final bool clearOnSearch;
  final _formKey = GlobalKey<FormState>();

  SearchWallpaperField({
    Key key,
    this.initialValue,
    @required this.onSubmitted,
    this.clearOnSearch = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<DarkMode>(context).isDarkModeOn;
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: initialValue,
              autofocus: false,
              textInputAction: TextInputAction.search,
              onChanged: (s) => value = s,
              onFieldSubmitted: (value) {
                if (clearOnSearch) _formKey.currentState.reset();
                onSubmitted(value);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark ? kDarkBackground : kLightBackground,
                hintText: 'Find Wallpaper...',
                hintStyle: TextStyle(
                  color: isDark
                      ? Colors.white.withOpacity(0.5)
                      : Colors.black.withOpacity(.3),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              color: isDark
                  ? Colors.white.withOpacity(0.5)
                  : Colors.black.withOpacity(.3),
            ),
            onPressed: () {
              if (clearOnSearch) _formKey.currentState.reset();
              onSubmitted(value);
            },
          ),
        ],
      ),
    );
  }
}
