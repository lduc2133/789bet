import 'package:flutter/material.dart';

class LocalImageWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final String url;
  final BoxFit? boxFit;
  final BorderRadius? borderRadius;

  const LocalImageWidget(
      {Key? key,
      this.height,
      this.width,
      required this.url,
      this.boxFit,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius:
            borderRadius != null ? borderRadius : BorderRadius.circular(0),
        image: DecorationImage(
          image: AssetImage(
            url,
          ),
          fit: boxFit != null ? boxFit : BoxFit.cover,
        ),
      ),
    );
  }
}
