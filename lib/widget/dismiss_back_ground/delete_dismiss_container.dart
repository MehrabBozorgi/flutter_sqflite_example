import 'package:flutter/material.dart';

class DeleteDismiss extends StatelessWidget {
  const DeleteDismiss({Key? key, required this.verticalMargin})
      : super(key: key);
  final double verticalMargin;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(
        vertical: height * verticalMargin,
        horizontal: width * 0.03,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(width * 0.03),
      ),
      child: const Icon(Icons.delete_forever, color: Colors.white),
    );
  }
}
