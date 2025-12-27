import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CategoryGrid extends StatelessWidget {
  final List<dynamic> categories;
  // Pastel colors list matched from RN code
  final List<Color> pastelColors = [
    Color(0xFFE3F2FD), Color(0xFFE8F5E9), Color(0xFFFFF3E0), Color(0xFFF3E5F5),
    Color(0xFFFCE4EC), Color(0xFFFFF8E1), Color(0xFFE0F7FA), Color(0xFFF9FBE7),
    Color(0xFFFBE9E7), Color(0xFFEDE7F6), Color(0xFFE0F2F1), Color(0xFFFFFDE7),
  ];

  CategoryGrid({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return SizedBox.shrink();

    final topCategories = categories.length > 7 ? categories.sublist(0, 7) : categories;
    // Calculate sizes
    final width = MediaQuery.of(context).size.width;
    final itemSpacing = 4.0;
    // (width - 12 padding * 2)/4 items roughly, adjusting for equal spacing
    // RN logic: (width - ITEM_SPACING * 6) / 4. 
    // We will use a GridView or Wrap to approximate.
    final itemWidth = (width - 24 - (itemSpacing * 3)) / 4; 

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shop By Category',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Wrap(
            spacing: itemSpacing,
            runSpacing: 12,
            alignment: WrapAlignment.spaceBetween,
            children: [
              ...topCategories.asMap().entries.map((entry) {
                final idx = entry.key;
                final cat = entry.value;
                final color = pastelColors[idx % pastelColors.length];
                return _buildCategoryItem(context, cat, color, itemWidth);
              }).toList(),

              // "All Categories" Button
               _buildAllCategoriesButton(context, itemWidth),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, dynamic cat, Color bgColor, double width) {
    final cardSize = width * 0.85;
    return GestureDetector(
      onTap: () => print('Pressed ${cat['title']}'),
      child: Container(
        width: width,
        child: Column(
          children: [
            Container(
              width: cardSize,
              height: cardSize,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              padding: EdgeInsets.all(8),
              child: CachedNetworkImage(
                imageUrl: cat['image'],
                fit: BoxFit.contain,
                placeholder: (context, url) => Center(child: CircularProgressIndicator(strokeWidth: 2)),
                errorWidget: (context, url, error) => Icon(Icons.error, size: 20),
              ),
            ),
            SizedBox(height: 5),
            Text(
              cat['title'],
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllCategoriesButton(BuildContext context, double width) {
    final cardSize = width * 0.85;
    return GestureDetector(
      onTap: () => _showAllCategoriesModal(context),
      child: Container(
        width: width,
        child: Column(
          children: [
            Container(
              width: cardSize,
              height: cardSize,
              decoration: BoxDecoration(
                color: Color(0xFFF0F4FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Theme.of(context).primaryColor),
              ),
              child: Icon(FeatherIcons.grid, color: Theme.of(context).primaryColor),
            ),
            SizedBox(height: 5),
            Text(
              'All Categories',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showAllCategoriesModal(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('All Categories', style: Theme.of(context).textTheme.titleLarge),
                IconButton(icon: Icon(FeatherIcons.x), onPressed: () => Navigator.pop(context)),
              ],
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                   final cat = categories[index];
                   final color = pastelColors[index % pastelColors.length];
                   // Use a simpler layout for the grid
                   return Column(
                     children: [
                       Expanded(
                         child: Container(
                           decoration: BoxDecoration(
                             color: color,
                             borderRadius: BorderRadius.circular(12),
                           ),
                           padding: EdgeInsets.all(12),
                           child: CachedNetworkImage(
                             imageUrl: cat['image'],
                             fit: BoxFit.contain,
                           ),
                         ),
                       ),
                       SizedBox(height: 4),
                       Text(cat['title'], textAlign: TextAlign.center, maxLines: 2, style: TextStyle(fontSize: 12)),
                     ],
                   );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
