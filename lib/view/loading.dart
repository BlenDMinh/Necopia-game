import 'package:flutter/material.dart';
import 'package:necopia/const/color.dart';

Widget loading(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return Container(
    color: primaryPurpleLighter,
    child: Center(
      child: Image.asset(
        "assets/images/cat-dance.gif",
        width: width / 1.5,
        fit: BoxFit.fitHeight,
      ),
    ),
  );
}
