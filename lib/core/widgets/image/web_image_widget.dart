import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WebImageWidget extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final BorderRadius? borderRadius;

  const WebImageWidget(
      {Key? key,
      required this.url,
      this.width,
      this.height,
      this.boxFit,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        height: height, //50
        width: width, //50
        decoration: BoxDecoration(
          borderRadius:
              borderRadius != null ? borderRadius : BorderRadius.circular(0),
          image: DecorationImage(
              image: imageProvider,
              fit: boxFit != null ? boxFit : BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => Center(
        child: Container(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
