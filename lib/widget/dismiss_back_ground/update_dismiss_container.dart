import 'package:flutter/material.dart';

class EditDismiss extends StatelessWidget {
  const EditDismiss({Key? key, required this.verticalMargin})
      : super(key: key);
  final double verticalMargin;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.symmetric(
        vertical: height * verticalMargin,
        horizontal: width * 0.03,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(width * 0.03),
      ),
      child: const Icon(Icons.edit, color: Colors.white),
    );
  }
}
