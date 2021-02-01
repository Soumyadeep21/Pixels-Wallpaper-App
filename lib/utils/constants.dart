import 'package:flutter/material.dart';
import 'package:wallpaper_app/utils/secrets.dart';

const String kBaseUrl = 'https://pixabay.com/';
const String kApiKey = Secrets.API_KEY;

const double kDefaultPadding = 20.0;

const LinearGradient kLightGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xffE5ECF5),
    Color(0xffFAFAFA),
  ],
);
const LinearGradient kDarkGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xff211A34),
    Color(0xff181A20),
  ],
);

const Color kLightBackground = Color(0xffFAFAFA);
const Color kDarkBackground = Color(0xff181A20);

const Color kButtonLight = Color(0xff476DDB);
const Color kButtonDark = Color(0xff4DA2B0);

const List<String> kCategories = [
  'Animals',
  'Food',
  'Travel',
  'Nature',
  'Sports',
  'Places',
  'Backgrounds',
  'Fashion',
  'Health',
  'People',
  'Computer',
  'Transportation',
  'Buildings',
  'Business',
  'Education',
  'Music',
  'Feelings',
];

const Map<String, Color> kSearchColors = {
  "Red": Color(0xffF8433F),
  "Orange": Color(0xffFCBB3D),
  "Yellow": Color(0xffFDE73A),
  "Green": Color(0xff5FE013),
  "Turquoise": Color(0xff31D7E9),
  "Blue": Color(0xff347DFA),
  "Lilac": Color(0xffCD83F7),
  "Pink": Color(0xffF7C1FF),
  "White": Color(0xffFFFFFF),
  "Gray": Color(0xffBBBBBB),
  "Black": Color(0xff000000),
  "Brown": Color(0xffAE5928),
};
