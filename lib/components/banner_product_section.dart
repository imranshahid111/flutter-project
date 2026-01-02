import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'product_card.dart';
import 'common_image.dart';

class BannerProductSection extends StatefulWidget {
  final String title;
  final Map<String, dynamic>? banner; // {uri: '...'}
  final List<dynamic> products;
  final Function(dynamic)? onAddToCart;
  final Function(dynamic)? onProductPress;
  final VoidCallback? onViewAll;

  const BannerProductSection({
    Key? key,
    required this.title,
    this.banner,
    required this.products,
    this.onAddToCart,
    this.onProductPress,
    this.onViewAll,
  }) : super(key: key);

  @override
  State<BannerProductSection> createState() => _BannerProductSectionState();
}

class _BannerProductSectionState extends State<BannerProductSection> {
  // Logic from RN: calculate height based on ratio, but for Flutter we can just use AspectRatio widget
  
  void _openProductModal(BuildContext context, dynamic item) {
    widget.onProductPress?.call(item);
    
    // Simple state for the modal
    int qty = 1;

    showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final double price = (item['price'] as num).toDouble();
            final double total = price * qty;
            
            return Container(
              padding: EdgeInsets.all(16),
              height: 400, // Fixed height or auto
              child: Column(
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['title'], style: Theme.of(context).textTheme.titleLarge),
                      IconButton(icon: Icon(FeatherIcons.x), onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        width: 96, height: 96,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: CommonImage(imageUrl: item['image']),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rs $price', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                            SizedBox(height: 12),
                            Container(
                              width: 126,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(FeatherIcons.minus, size: 16),
                                    onPressed: () => setModalState(() { if(qty > 1) qty--; }),
                                  ),
                                  Text('$qty', style: TextStyle(fontWeight: FontWeight.bold)),
                                  IconButton(
                                    icon: Icon(FeatherIcons.plus, size: 16),
                                    onPressed: () => setModalState(() { qty++; }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        widget.onAddToCart?.call({...item, 'qty': qty});
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.shopping_cart, color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text('Add to cart', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text('Rs $total', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          }
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: widget.onViewAll,
                child: Row(
                  children: [
                    Text('View all', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
                    Icon(FeatherIcons.chevronRight, size: 16, color: Theme.of(context).primaryColor),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Banner
        if (widget.banner != null && widget.banner!['uri'] != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: AspectRatio(
              aspectRatio: 16 / 9, // Fallback ratio
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                clipBehavior: Clip.hardEdge,
                child: CommonImage(
                  imageUrl: widget.banner!['uri'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

        // Products
        Container(
          height: 250, // Height for ProductCard + padding
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              final item = widget.products[index];
              return ProductCard(
                item: item,
                onTap: () => _openProductModal(context, item),
                onAdd: () => _openProductModal(context, item),
              );
            },
          ),
        ),
      ],
    );
  }
}
