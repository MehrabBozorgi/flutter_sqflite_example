import 'package:flutter/material.dart';
import '../responsive/responsive.dart';
import '../style_color.dart';
import '../style_color.dart';

class SmallRedElevationButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;

  const SmallRedElevationButton({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: width * 0.03,
        horizontal: width * 0.02,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: primaryColor,
          elevation: 3,
          shadowColor: shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(width * 0.02),
          ),
        ),
        child: Text(
          text,
          style: Responsive.isMobile(context)
              ? bodyWhiteMobileStyle
              : bodyWhiteTabletStyle,
        ),
        onPressed: () => onPress(),
      ),
    );
  }
}
