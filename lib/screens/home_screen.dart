import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/header.dart';
import '../components/banner_carousel.dart';
import '../components/category_grid.dart';
import '../components/banner_product_section.dart';
import '../providers/app_state.dart';
import 'package:feather_icons/feather_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _drawerController;
  late Animation<Offset> _drawerSlide;
  late Animation<double> _drawerOpacity;

  // Data matched from RN
  final List<Map<String, String>> banners = [
    {'id': '1', 'uri': 'https://g-cdn.blinkco.io/ordering-system/55544/web_splash/1756461224.jpg'},
    {'id': '2', 'uri': 'https://g-cdn.blinkco.io/ordering-system/55544/web_splash/1754654789.jpg'},
    {'id': '3', 'uri': 'https://g-cdn.blinkco.io/ordering-system/55544/web_splash/1754653347.jpg'},
  ];

  final List<Map<String, dynamic>> categories = [
    { 'title': 'Ultra Fresh',        'image': 'https://g-cdn.blinkco.io/ordering-system/55544/menu_image/1756978180753.jpg' },
    { 'title': 'Grocery',            'image': 'https://g-cdn.blinkco.io/ordering-system/55544/menu_image/1756978118134.jpg' },
    { 'title': 'Dry Fruits',         'image': 'https://g-cdn.blinkco.io/ordering-system/55544/menu_image/1756977694128.jpg' },
    { 'title': 'Breakfast & Dairy',  'image': 'https://g-cdn.blinkco.io/ordering-system/55544/menu_image/1756978102069.jpg' },
    { 'title': 'Frozen Food',        'image': 'https://g-cdn.blinkco.io/ordering-system/55544/menu_image/1756978084926.jpg' },
    { 'title': 'Baby Products',      'image': 'https://g-cdn.blinkco.io/ordering-system/55544/menu_image/1756978135150.jpg' },
    { 'title': 'Health & Beauty',    'image': 'https://g-cdn.blinkco.io/ordering-system/55544/menu_image/1756978150248.jpg' },
    { 'title': 'Snacks',             'image': 'https://g-cdn.blinkco.io/ordering-system/55544/menu_image/1756978068847.jpg' },
    { 'title': 'Beverages',          'image': 'https://images.unsplash.com/photo-1528825871115-3581a5387919?q=80&w=800' },
    { 'title': 'Household',          'image': 'https://images.unsplash.com/photo-1559138658-df9aa5b51478?q=80&w=800' },
  ];

  @override
  void initState() {
    super.initState();
    _drawerController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _drawerSlide = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(CurvedAnimation(parent: _drawerController, curve: Curves.easeOutCubic));
    _drawerOpacity = Tween<double>(begin: 0, end: 0.35).animate(CurvedAnimation(parent: _drawerController, curve: Curves.easeOut));
  }

  void _toggleDrawer() {
    if (_drawerController.isCompleted) {
      _drawerController.reverse();
    } else {
      _drawerController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: CustomHeaderDelegate(
                  onMenuPress: _toggleDrawer,
                  onCartPress: () => Navigator.pushNamed(context, '/cart'),
                  onFavouritePress: () => Navigator.pushNamed(context, '/favourites'),
                  onSearchChange: (val) {},
                  onSearchSubmit: (val) {},
                  cartCount: appState.cartCount,
                ),
              ),
            SliverToBoxAdapter(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const SizedBox(height: 10),

      // 🔥 FULL WIDTH — DO NOT WRAP IN PADDING
      BannerCarousel(banners: banners),

      const SizedBox(height: 10),

      // Everything BELOW can have padding safely
      Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            CategoryGrid(categories: categories),
            const SizedBox(height: 10),

            BannerProductSection(
              title: "Ultra Fresh",
              banner: {
                'uri':
                    'https://g-cdn.blinkco.io/ordering-system/55544/splash/1742625689.jpg'
              },
              products: [
                {
                  'id': 'p1',
                  'title': 'Fresh Mutton Mix',
                  'price': 2399,
                  'image':
                      'https://em-cdn.eatmubarak.pk/55544/gallery/MENU%20BONELESS%20HANDI%20500GM.png'
                },
                {
                  'id': 'p2',
                  'title': 'Fresh Cauliflower',
                  'price': 49,
                  'image':
                      'https://images.unsplash.com/photo-1540420773420-3366772f4999?q=80&w=800',
                  'badge': 'Best Seller'
                },
                {
                  'id': 'p3',
                  'title': 'Fresh Beef With Bone',
                  'price': 1299,
                  'image':
                      'https://images.unsplash.com/photo-1544025162-d76694265947?q=80&w=800'
                },
                {
                  'id': 'p4',
                  'title': 'Tomatoes (1kg)',
                  'price': 119,
                  'image':
                      'https://images.unsplash.com/photo-1546470428-2b4f1a2c641c?q=80&w=800'
                },
              ],
              onAddToCart: (item) =>
                  appState.addToCart(Map<String, dynamic>.from(item)),
            ),

            const SizedBox(height: 10),

            BannerProductSection(
              title: "Grocery",
              banner: {
                'uri':
                    'https://g-cdn.blinkco.io/ordering-system/55544/splash/1744283878.jpg'
              },
              products: [
                {
                  'id': 'g1',
                  'title': 'Atta 10kg',
                  'price': 1999,
                  'image':
                      'https://em-cdn.eatmubarak.pk/55544/gallery/MENU%20BONELESS%20HANDI%20500GM.png'
                },
                {
                  'id': 'g2',
                  'title': 'Cooking Oil 3L',
                  'price': 2450,
                  'image':
                      'https://em-cdn.eatmubarak.pk/55544/gallery/MENU%20BONELESS%20HANDI%20500GM.png'
                },
                {
                  'id': 'g3',
                  'title': 'Sugar 5kg',
                  'price': 720,
                  'image':
                      'https://images.unsplash.com/photo-1615485921621-43ad2825d3cf?q=80&w=800'
                },
                {
                  'id': 'g4',
                  'title': 'Rice 5kg',
                  'price': 1850,
                  'image':
                      'https://images.unsplash.com/photo-1517685352821-92cf88aee5a5?q=80&w=800'
                },
              ],
              onAddToCart: (item) =>
                  appState.addToCart(Map<String, dynamic>.from(item)),
            ),

            const SizedBox(height: 10),

            BannerProductSection(
              title: "Dry Fruits",
              banner: {
                'uri':
                    'https://g-cdn.blinkco.io/ordering-system/55544/splash/1754738547.jpg'
              },
              products: [
                {
                  'id': 'd1',
                  'title': 'Almonds 500g',
                  'price': 1499,
                  'image':
                      'https://em-cdn.eatmubarak.pk/55544/gallery/MENU%20BONELESS%20HANDI%20500GM.png'
                },
                {
                  'id': 'd2',
                  'title': 'Cashews 500g',
                  'price': 1799,
                  'image':
                      'https://em-cdn.eatmubarak.pk/55544/gallery/MENU%20BONELESS%20HANDI%20500GM.png'
                },
                {
                  'id': 'd3',
                  'title': 'Walnuts 500g',
                  'price': 1299,
                  'image':
                      'https://images.unsplash.com/photo-1615485737651-ae73f45e15b0?q=80&w=800'
                },
                {
                  'id': 'd4',
                  'title': 'Raisins 500g',
                  'price': 699,
                  'image':
                      'https://images.unsplash.com/photo-1464965911861-746a04b4bca6?q=80&w=800'
                },
              ],
              onAddToCart: (item) =>
                  appState.addToCart(Map<String, dynamic>.from(item)),
            ),
          ],
        ),
      ),
    ],
  ),
),
   ],
          ),
          
          // Drawer Overlay
          AnimatedBuilder(
            animation: _drawerController,
            builder: (context, child) {
              if (_drawerController.value == 0) return SizedBox.shrink();
              return GestureDetector(
                onTap: _toggleDrawer,
                child: Container(
                  color: Colors.black.withOpacity(_drawerOpacity.value),
                ),
              );
            },
          ),
          
          // Custom Drawer logic replicated for 100% sameness
          SlideTransition(
            position: _drawerSlide,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.78,
              constraints: BoxConstraints(maxWidth: 320),
              color: Theme.of(context).cardColor,
              child: SafeArea(
                 child: Column(
                   children: [
                     Container(
                       height: 100,
                       margin: EdgeInsets.all(12),
                       decoration: BoxDecoration(
                         color: Theme.of(context).primaryColor.withOpacity(0.1),
                         borderRadius: BorderRadius.circular(14),
                       ),
                       alignment: Alignment.center,
                       child: Image.asset('assets/rubaika_logo.png', width: 140, fit: BoxFit.contain),
                     ),
                     SizedBox(height: 10),
                     _buildDrawerItem('Home'),
                     _buildDrawerItem('Categories'),
                     _buildDrawerItem('Orders'),
                     _buildDrawerItem('Favourites'),
                     _buildDrawerItem('Cart'),
                   ],
                 ),
              ),
               
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDrawerItem(String title) {
    return Container(
      height: 44,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle), margin: EdgeInsets.only(right: 10)),
          Text(title, style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSurface)),
        ],
      ),
    );
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    _drawerController.dispose();
    super.dispose();
  }
}
