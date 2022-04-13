import 'dart:io';
import 'package:flutter/material.dart';

import '../../../widget/border.dart';
import '../../widget/navigator/navigator.dart';

//Show image picture
class ImageScreen extends StatelessWidget {
  const ImageScreen({
    Key? key,
    required this.image,
    required this.heroTag,
  }) : super(key: key);
  final File image;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: borderWidget(context),
                child: Hero(
                  tag: heroTag,
                  child: FadeInImage(
                    placeholder: const AssetImage(
                      'loading.gif',
                    ),
                    image: FileImage(image),
                    width: width,
                    height: height,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    placeholderFit: BoxFit.contain,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  navigatorPopWidget(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
