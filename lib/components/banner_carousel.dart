import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'common_image.dart';

class BannerCarousel extends StatefulWidget {
  final List<dynamic> banners; // [{id, uri}]
  final double height;
  final Duration autoInterval;
  final double borderRadius;
  final Function(dynamic, int)? onPressBanner;

  const BannerCarousel({
    Key? key,
    required this.banners,
    this.height = 150,
    this.autoInterval = const Duration(milliseconds: 3500),
    this.borderRadius = 16.0,
    this.onPressBanner,
  }) : super(key: key);

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: widget.height,
            viewportFraction: 0.98, // 98% WIDTH
            enlargeCenterPage: false,
            autoPlay: true,
            autoPlayInterval: widget.autoInterval,
            onPageChanged: (index, _) {
              setState(() => _currentIndex = index);
            },
          ),
          items: widget.banners.asMap().entries.map((entry) {
            final banner = entry.value;
            final uri = banner is Map ? banner['uri'] : null;

            return GestureDetector(
              onTap: () =>
                  widget.onPressBanner?.call(banner, entry.key),
              child: SizedBox(
                width: double.infinity, // 🔥 FORCE FULL WIDTH
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius),
                  child: CommonImage(
                    imageUrl: uri,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 10),

        // Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.banners.asMap().entries.map((entry) {
            final isActive = _currentIndex == entry.key;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: isActive ? 16 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context)
                    .primaryColor
                    .withOpacity(isActive ? 1 : 0.25),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
