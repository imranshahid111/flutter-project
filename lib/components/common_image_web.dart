
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
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
    // Unique ID for each image
    final String viewType = 'img-${imageUrl.hashCode}';

    // Register the view factory
    ui_web.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      final img = html.ImageElement()
        ..src = imageUrl
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = _getBoxFit(fit);
      return img;
    });

    return SizedBox(
      width: width,
      height: height,
      child: HtmlElementView(viewType: viewType),
    );
  }

  String _getBoxFit(BoxFit fit) {
    switch (fit) {
      case BoxFit.cover:
        return 'cover';
      case BoxFit.contain:
        return 'contain';
      case BoxFit.fill:
        return 'fill';
      case BoxFit.fitHeight:
        return 'cover'; // Approximation
      case BoxFit.fitWidth:
        return 'cover'; // Approximation
      case BoxFit.none:
        return 'none';
      case BoxFit.scaleDown:
        return 'scale-down';
    }
  }
}
