import 'package:flutter/material.dart';
import 'package:muslim_task/constants.dart';

abstract class Styles {
  static const textStyle18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  static const textStyle20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );
  static const textStyle30 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w900,
    letterSpacing: 1.2,
  );
  static const textStyle14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const textStyle16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}

abstract class AppFontStyle {

  static TextStyle descStyle = TextStyle(
      color: Color(0xff636363),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.3);

  static TextStyle labelStyle = TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      height: 1.3);

  static TextStyle coloredLabelStyle = TextStyle(
      color: kBackgroundColor,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      height: 1.3);

  static TextStyle appBarTitle = TextStyle(
      color: Colors.white,
      fontSize: 18,
      //mediam
      fontWeight: FontWeight.w500,
      height: 1.3);



  static TextStyle contentStyle = TextStyle(
      color: Color(0xff6D6D6D),
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.3);

  static TextStyle detailsStyle = TextStyle(
      color: Colors.black,
      fontSize: 10,
      fontWeight: FontWeight.w600,
      height: 1.3);

  static TextStyle bigBoldTitleStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      height: 1.3);

  static TextStyle labelSemiBoldStyle = TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.w600,
      height: 1.3);
}
