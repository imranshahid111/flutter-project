
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
    throw UnimplementedError('Unsupported');
  }
}
