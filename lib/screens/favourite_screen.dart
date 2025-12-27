import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:feather_icons/feather_icons.dart';
import '../providers/app_state.dart';
import '../components/product_card.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // For demo, we are mocking favorites since the 'add to fav' isn't explicitly wired in the RN 'onAddToCart'
    // But we'll use the provider logic
    final appState = Provider.of<AppState>(context);
    // Mock initial data if empty to match RN screenshots/demo
    final items = appState.favourites.isNotEmpty ? appState.favourites : [
       { 'id': 'p1', 'title': 'Fresh Mutton Mix 500g', 'price': 2399, 'image': 'https://em-cdn.eatmubarak.pk/55544/gallery/MENU%20BONELESS%20HANDI%20500GM.png' },
       { 'id': 'g2', 'title': 'Cooking Oil 3L', 'price': 2450, 'image': 'https://em-cdn.eatmubarak.pk/55544/gallery/MENU%20BONELESS%20HANDI%20500GM.png' },
       { 'id': 'v1', 'title': 'Tomatoes (1kg)', 'price': 119, 'image': 'https://images.unsplash.com/photo-1546470428-2b4f1a2c641c?q=80&w=800' },
    ];
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: Icon(FeatherIcons.trash2), onPressed: () {}), // Clear logic skipped for brevity
        ],
      ),
      body: items.isEmpty
          ? Center(child: Text("No favourites yet"))
          : GridView.builder(
              padding: EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                childAspectRatio: 0.7, 
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ProductCard(
                  item: item,
                  onAdd: () => appState.addToCart(item),
                  onTap: () {},
                );
              },
            ),
    );
  }
}
