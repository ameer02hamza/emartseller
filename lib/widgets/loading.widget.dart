import 'package:emartseller/const/colors.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator({Color color = primaryColor}) {
  return  CircularProgressIndicator(
    semanticsLabel:const String.fromEnvironment("Loading..."),
    valueColor: AlwaysStoppedAnimation<Color>(color),
  );
}