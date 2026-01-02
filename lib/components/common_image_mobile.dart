
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PlatformCommonImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const PlatformCommonImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    required this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Center(child: CircularProgressIndicator(strokeWidth: 2)),
      errorWidget: (context, url, error) => Icon(Icons.error, size: 20, color: Colors.grey),
    );
  }
}
