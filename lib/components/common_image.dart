
import 'package:flutter/material.dart';

import 'common_image_stub.dart'
    if (dart.library.io) 'common_image_mobile.dart'
    if (dart.library.html) 'common_image_web.dart';

class CommonImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const CommonImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformCommonImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
