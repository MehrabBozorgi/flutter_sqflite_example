import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../responsive/responsive.dart';
import '../style_color.dart';

class ElevationButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final double minSizeW;

  const ElevationButtonWidget({
    Key? key,
    required this.text,
    required this.onPress,
    required this.minSizeW,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return FadeInLeft(
      child: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            alignment: Alignment.center,
            backgroundColor: primaryColor,
            elevation: 5,
            shadowColor: shadowColor,
            fixedSize: Size(minSizeW, height*0.06),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(width),
            ),
          ),
          child: Text(text,
              style: Responsive.isMobile(context)
                  ? titleWhiteMobileStyle
                  : titleWhiteTabletStyle),
          onPressed: () => onPress(),
        ),
      ),
    );
  }
}
