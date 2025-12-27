import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import '../constants/theme.dart';

class CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final VoidCallback onMenuPress;
  final VoidCallback onCartPress;
  final VoidCallback onFavouritePress;
  final Function(String) onSearchChange;
  final Function(String) onSearchSubmit;
  final String locationText;
  final int cartCount;

  CustomHeaderDelegate({
    required this.onMenuPress,
    required this.onCartPress,
    required this.onFavouritePress,
    required this.onSearchChange,
    required this.onSearchSubmit,
    this.locationText = 'Lahore, LDA',
    this.cartCount = 0,
  });

  static const double _fullHeight = 112.0;
  static const double _collapsedHeight = 70.0; // Reduced from 80 to fit content better

  @override
  double get minExtent => _collapsedHeight + 0; // Add status bar height if needed, but safe area handles it usually
  @override
  double get maxExtent => _fullHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);
    final double collapseRange = maxExtent - minExtent;
    final double progress = (shrinkOffset / collapseRange).clamp(0.0, 1.0);
    
    // Fade out bottom row
    final double bottomOpacity = (1.0 - (progress * 3)).clamp(0.0, 1.0);
    final double bottomTranslateY = -shrinkOffset;

    return Container(
      color: theme.colorScheme.primary,
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              SizedBox(height: 8), // Top padding
              // Top Row
              SizedBox(
                height: 48, // Slightly taller for better touch targets
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(FeatherIcons.menu, color: theme.colorScheme.onPrimary),
                      onPressed: onMenuPress,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                          ],
                        ),
                        child: TextField(
                          onChanged: onSearchChange,
                          onSubmitted: onSearchSubmit,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: 'Search products...',
                            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                            prefixIcon: Icon(FeatherIcons.search, size: 18, color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: Icon(FeatherIcons.xCircle, size: 18, color: Colors.grey),
                              onPressed: () {
                                onSearchChange('');
                              },
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    IconButton(
                      icon: Icon(FeatherIcons.heart, color: theme.colorScheme.onPrimary, size: 24),
                      onPressed: onFavouritePress,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                    SizedBox(width: 16),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        IconButton(
                          icon: Icon(FeatherIcons.shoppingCart, color: theme.colorScheme.onPrimary, size: 24),
                          onPressed: onCartPress,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                        if (cartCount > 0)
                          Positioned(
                            right: -4,
                            top: -4,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.secondary,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: theme.colorScheme.primary, width: 2),
                              ),
                              constraints: BoxConstraints(minWidth: 20, minHeight: 20),
                              child: Text(
                                cartCount > 99 ? '99+' : cartCount.toString(),
                                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Bottom Row (Collapsible)
               if (bottomOpacity > 0)
                Expanded(
                  child: Opacity(
                    opacity: bottomOpacity,
                    child: Transform.translate(
                      offset: Offset(0, bottomTranslateY * 0.5), // Parallax effect
                      child: Container(
                        padding: EdgeInsets.only(top: 12),
                         alignment: Alignment.topCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: theme.dividerColor),
                              ),
                              child: Row(
                                children: [
                                  Icon(FeatherIcons.checkCircle, size: 14, color: theme.colorScheme.primary),
                                  SizedBox(width: 6),
                                  Text(
                                    'Delivery',
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Icon(FeatherIcons.mapPin, size: 16, color: theme.colorScheme.onPrimary),
                                SizedBox(width: 6),
                                Container(
                                  constraints: BoxConstraints(maxWidth: 180),
                                  child: Text(
                                    locationText,
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: theme.colorScheme.onPrimary),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(Icons.keyboard_arrow_down, size: 16, color: theme.colorScheme.onPrimary),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant CustomHeaderDelegate oldDelegate) {
    return oldDelegate.cartCount != cartCount ||
           oldDelegate.locationText != locationText;
  }
}
