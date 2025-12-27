import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/app_state.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final items = appState.cartItems;
    final total = appState.total;
    final subtotal = appState.subtotal;
    final delivery = appState.delivery;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('My Cart', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      bottomNavigationBar: items.isEmpty ? null : Container(
         padding: EdgeInsets.all(16),
         decoration: BoxDecoration(
           color: Theme.of(context).cardColor,
           border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
         ),
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             _buildSummaryRow(context, 'Subtotal', subtotal),
             _buildSummaryRow(context, 'Delivery', delivery, isFree: delivery == 0),
             SizedBox(height: 10),
             _buildSummaryRow(context, 'Total', total, isBold: true),
             SizedBox(height: 16),
             SizedBox(
               height: 48,
               width: double.infinity,
               child: ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Theme.of(context).primaryColor,
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                 ),
                 onPressed: () {},
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Row(children: [Icon(FeatherIcons.creditCard, color: Colors.white, size: 18), SizedBox(width: 8), Text('Checkout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))]),
                     Text('Rs ${total.toInt()}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                   ],
                 ),
               ),
             ),
           ],
         ),
      ),
      body: items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 64, height: 64,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    child: Icon(FeatherIcons.shoppingCart, size: 36, color: Colors.grey),
                  ),
                  SizedBox(height: 12),
                  Text('Your cart is empty', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  Text('Add something tasty to get started.', style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.all(12),
              itemCount: items.length,
              separatorBuilder: (_, __) => SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = items[index];
                return Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Theme.of(context).dividerColor),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 72, height: 72,
                        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
                        child: CachedNetworkImage(imageUrl: item['image'], fit: BoxFit.cover),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['title'], maxLines: 2, style: TextStyle(fontWeight: FontWeight.w600)),
                            SizedBox(height: 4),
                            Text('Rs ${item['price']}', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                            
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Stepper
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Theme.of(context).dividerColor),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(FeatherIcons.minus, size: 14),
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                                        onPressed: () => appState.updateCartQty(item['id'], item['qty'] - 1),
                                      ),
                                      Text('${item['qty']}', style: TextStyle(fontWeight: FontWeight.bold)),
                                      IconButton(
                                        icon: Icon(FeatherIcons.plus, size: 14),
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                                        onPressed: () => appState.updateCartQty(item['id'], item['qty'] + 1),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Remove
                                GestureDetector(
                                  onTap: () => appState.removeFromCart(item['id']),
                                  child: Row(
                                    children: [
                                      Icon(FeatherIcons.trash2, size: 16, color: Colors.red),
                                      SizedBox(width: 4),
                                      Text('Remove', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 13)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, double val, {bool isBold = false, bool isFree = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13.5, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(isFree ? 'Free' : 'Rs ${val.toInt()}', style: TextStyle(fontSize: 13.5, fontWeight: isBold ? FontWeight.w800 : FontWeight.w600)),
        ],
      ),
    );
  }
}
