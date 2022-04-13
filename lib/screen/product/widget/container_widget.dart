import 'package:flutter/material.dart';

import '../../../../widget/border.dart';
import '../../../widget/style_color.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    Key? key,
    required this.callback,
    required this.widget,
  }) : super(key: key);
  final VoidCallback callback;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Card(
      shape:shapeWidget(context),
      margin: EdgeInsets.all(width * 0.015),
      elevation: 3,
      shadowColor: shadowColor,
      color: Colors.white,
      child: InkWell(
        onTap: callback,
        borderRadius:borderWidget(context),
        child: Container(
          width: width*0.4,
          height: width * 0.4,
          padding: EdgeInsets.all(width * 0.02),
          alignment: Alignment.center,

          child: widget,
        ),
      ),
    );
  }
}
