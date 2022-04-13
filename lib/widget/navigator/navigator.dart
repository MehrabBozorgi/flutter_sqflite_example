import 'package:flutter/material.dart';

navigatorPushWidget(BuildContext context, widget) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => widget),
  );
}

navigatorReplaceWidget(BuildContext context, widget) {
   Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => widget),
  );
}

navigatorPopWidget(BuildContext context) {
   Navigator.of(context).pop();
}
