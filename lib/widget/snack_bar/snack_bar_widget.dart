import 'package:flutter/material.dart';
import '../responsive/responsive.dart';
import '../style_color.dart';
snackBarSuccessWidget(context, text) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        text,
        style: Responsive.isMobile(context)
            ? bodyWhiteMobileStyle
            : bodyWhiteTabletStyle,
      ),
      duration: const Duration(milliseconds: 1500),
    ),
  );
}

snackBarErrorWidget(context, text) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 5,
      backgroundColor: primaryColor,
      content: Text(
        text,
        style: Responsive.isMobile(context)
            ? bodyWhiteMobileStyle
            : bodyWhiteTabletStyle,
      ),
      duration: const Duration(milliseconds: 2000),
    ),
  );
}
