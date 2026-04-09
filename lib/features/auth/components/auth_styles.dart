import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const green = Color.fromRGBO(36, 196, 105, 1);
  static const darkGreen = Color.fromRGBO(8, 110, 61, 1);
  static const text = Color.fromRGBO(20, 43, 33, 1);

  static const bgTop = Color.fromRGBO(240, 251, 244, 1);
  static const bgMid = Color.fromRGBO(218, 245, 230, 1);
  static const bgBottom = Color.fromRGBO(190, 238, 212, 1);
}

class AppTextStyles {
  static TextStyle title(double size, {Color color = AppColors.darkGreen}) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w900,
      height: 1.05,
      color: color,
    );
  }

  static TextStyle body(double size, {Color color = AppColors.text}) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static TextStyle button(double size, {Color color = Colors.white}) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w800,
      color: color,
    );
  }

  static TextStyle label(double size, {Color color = AppColors.text}) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.8,
      color: color,
    );
  }
}

class AppIcons {
  static const email = CupertinoIcons.mail_solid;
  static const password = CupertinoIcons.lock_fill;
  static const person = CupertinoIcons.person_fill;
  static const back = CupertinoIcons.arrow_left;
  static const group = CupertinoIcons.person_3_fill;
  static const list = CupertinoIcons.list_bullet_below_rectangle;
  static const check = CupertinoIcons.check_mark_circled_solid;
}
