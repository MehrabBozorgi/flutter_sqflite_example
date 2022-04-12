import 'package:flutter/material.dart';

shapeWidget(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(width * 0.03),
  );
}

borderWidget(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  return  BorderRadius.circular(width * 0.03);
}

bottomSheetborderWidget(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  return  RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(width * 0.02),
      topRight: Radius.circular(width * 0.02),
    ),
  );
}
