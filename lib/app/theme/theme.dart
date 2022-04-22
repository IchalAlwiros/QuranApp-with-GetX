import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kPrimaryColor = Color(0xff260F68);
Color kBlackColor = Color(0xff1F1449);
Color kWhiteColor = Color(0xffFFFFFF);
Color kGreyColor = Color(0xff9698A9);
Color kRedColor = Color(0xffF44771);
Color kPurpleLightColor = Color(0xffB9A2D8);
Color kBackgroundColor = Color(0xff431AA1);
Color kInactiveColor = Color(0xff9345F2);

Color kDarkPurple = Color(0xff1E0771);

Color kUnavaliableColor = Color(0xffEBECF1);
Color kAvailableColor = Color(0xffE0D9FF);

Color kTransparantColor = Colors.transparent;

ThemeData appLight = ThemeData(
    primaryColor: kBackgroundColor,
    scaffoldBackgroundColor: kWhiteColor,
    appBarTheme: AppBarTheme(
      backgroundColor: kInactiveColor,
    ));

ThemeData appDark = ThemeData(
    primaryColor: kBackgroundColor,
    scaffoldBackgroundColor: kDarkPurple,
    appBarTheme: AppBarTheme(
      backgroundColor: kDarkPurple,
    ),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.poppins(
        color: kWhiteColor,
      ),
      bodyText2: GoogleFonts.poppins(
        color: kWhiteColor,
      ),
    ));

double defaultMargin = 24.0;
double defaultRadius = 17.0;

TextStyle defaultTextStyle = GoogleFonts.poppins();

TextStyle blackTextStyle = GoogleFonts.poppins(
  color: kBlackColor,
);

TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: kWhiteColor,
);

TextStyle greyTextStyle = GoogleFonts.poppins(
  color: kGreyColor,
);

TextStyle greenAccentTextStyle = GoogleFonts.poppins(
  color: kInactiveColor,
);

TextStyle greenTextStyle = GoogleFonts.poppins(
  color: kPrimaryColor,
);

FontWeight light = FontWeight.w300;
FontWeight reguler = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;
