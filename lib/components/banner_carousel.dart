import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BannerCarousel extends StatefulWidget {
  final List<dynamic> banners; // List of {id, uri} or asset path strings
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
    if (widget.banners.isEmpty) return SizedBox.shrink();

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: widget.height,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: widget.autoInterval,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: widget.banners.map((banner) {
             // Handle different banner formats if necessary (String vs Map)
             // Assuming Map from the RN code: {id:'1', uri: '...'}
             final uri = (banner is Map) ? banner['uri'] : null;
             
             return GestureDetector(
               onTap: () => widget.onPressBanner?.call(banner, widget.banners.indexOf(banner)),
               child: Container(
                 width: MediaQuery.of(context).size.width,
                 margin: EdgeInsets.symmetric(horizontal: 0.0), // No margin to match full width concept or add padding if needed
                 child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 7), // Match RN padding
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: uri != null
                        ? CachedNetworkImage(
                            imageUrl: uri,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(color: Colors.grey[200]),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          )
                        : Image.asset(
                            'assets/rubaika_logo.png', // Fallback or handle asset images properly
                            fit: BoxFit.cover,
                          ),
                 ),
               ),
             );
          }).toList(),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.banners.asMap().entries.map((entry) {
            return Container(
              width: _currentIndex == entry.key ? 16.0 : 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Theme.of(context).primaryColor.withOpacity(
                  _currentIndex == entry.key ? 1.0 : 0.2
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
