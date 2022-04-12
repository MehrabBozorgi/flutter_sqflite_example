import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../responsive/responsive.dart';
import '../style_color.dart';

alertDialogWarning(
  BuildContext context,
  String title,
  String desc,
) {
  return AwesomeDialog(
    dialogBackgroundColor: backGroundColor,
    context: context,
    dialogType: DialogType.WARNING,
    animType: AnimType.SCALE,
    headerAnimationLoop: false,
    title: title,
    desc: desc,
    btnOkOnPress: () {},
    btnOkColor: Colors.amber[600],
    btnOkText: 'برگشت',
    buttonsTextStyle: Responsive.isMobile(context)
        ? bodyWhiteMobileStyle
        : bodyWhiteTabletStyle,
  ).show();
}

alertDialogError(
  BuildContext context,
  String title,
  String desc,
) {
  return AwesomeDialog(
          dialogBackgroundColor: backGroundColor,
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          headerAnimationLoop: false,
          title: title,
          desc: desc,
          btnOkOnPress: () {},
          btnOkColor: primaryColor,
          btnOkText: 'برگشت',
          buttonsTextStyle: Responsive.isMobile(context)
              ? bodyWhiteMobileStyle
              : bodyWhiteTabletStyle)
      .show();
}
