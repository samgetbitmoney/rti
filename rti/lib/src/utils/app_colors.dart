import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class AppColors {
  static const Color grey = Color(0xffE5E5E5);
  static const Color grey1 = Color(0xffF2F2F2);
  static const Color lightBlue = Color(0xffEDF8FF);
  static const Color black = Color(0xff323238);
  static const Color fontgrey = Color(0xff949C9E);
}

abstract class AppConstants {
  static DateFormat format = DateFormat('d MMM y');
  static DateFormat format1 = DateFormat('d MMM, y');
}
