import 'package:flutter/material.dart';
import 'package:flutter_sqflite_example/widget/responsive/responsive.dart';
import 'package:flutter_sqflite_example/widget/style_color.dart';

import 'convert_price_format.dart';



Widget getBodyBoldText(BuildContext context, text1, text2) {
  return RichText(
    maxLines: 3,
    text: TextSpan(
      children: [
        TextSpan(
          text: text1,
          style: Responsive.isMobile(context)
              ? bodyBlackMobileStyle
              : bodyBlackTabletStyle,
        ),
        TextSpan(
          text: text2,
          style: Responsive.isMobile(context)
              ? bodyBoldBlackMobileStyle
              : bodyBoldBlackTabletStyle,
        ),
      ],
    ),
  );
}


Widget getPriceText(BuildContext context, text1, text2) {
  return RichText(
    // maxLines: 2,
    text: TextSpan(
      children: [
        TextSpan(
          text: text1,
          style: Responsive.isMobile(context)
              ? bodyGreenMobileStyle
              : bodyGreenTabletStyle,
        ),
        TextSpan(
          text: convertPriceFormat(text2),
          style: Responsive.isMobile(context)
              ? bodyBoldGreenMobileStyle
              : bodyBoldGreenTabletStyle,
        ),
      ],
    ),
  );
}


