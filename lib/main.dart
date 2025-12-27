import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons/feather_icons.dart';

// ==========================================
// MAIN ENTRY POINT
// ==========================================
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: MyApp(),
    ),
  );
}

// ==========================================
// MAIN APPLICATION WIDGET
// ==========================================
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rubaika Cash & Carry',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF00A651), // Example Green
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        dividerColor: Colors.grey[200],
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF00A651),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF00A651),
          secondary: Color(0xFFFFC107), // Amber/Yellow
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black87,
        ),
        fontFamily: 'Roboto', // Or system default
      ),
      home: HomeScreen(),
    );
  }
}

// ==========================================
// APP STATE (PROVIDER)
// ==========================================
class AppState extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];
  List<Map<String, dynamic>> _favourites = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;
  List<Map<String, dynamic>> get favourites => _favourites;
  int get cartCount => _cartItems.length;

  void addToCart(Map<String, dynamic> item) {
    final index = _cartItems.indexWhere((i) => i['id'] == item['id']);
    if (index >= 0) {
      final currentQty = _cartItems[index]['qty'] ?? 1;
      final addedQty = item['qty'] ?? 1;
      _cartItems[index]['qty'] = currentQty + addedQty;
    } else {
      _cartItems.add({...item, 'qty': item['qty'] ?? 1});
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    _cartItems.removeWhere((item) => item['id'] == id);
    notifyListeners();
  }
}

// ==========================================
// HOME SCREEN
// ==========================================
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // --- DATA ---
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
  ];

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      // 1. Standard AppBar instead of custom Sliver Header
      appBar: AppBar(
        title: Text('Rubaika'),
        actions: [
          IconButton(
            icon: Icon(FeatherIcons.search),
            onPressed: () {},
          ),
          // Cart Icon with Badge
          Stack(
            children: [
              IconButton(
                icon: Icon(FeatherIcons.shoppingCart),
                onPressed: () {
                   // Navigate to cart (placeholder)
                },
              ),
              if (appState.cartCount > 0)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
                    child: Text(
                      '${appState.cartCount}',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                )
            ],
          )
        ],
      ),
      
      // 2. Standard Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Container(
                     padding: EdgeInsets.all(8),
                     color: Colors.white,
                     child: Image.asset('assets/rubaika_logo.png', height: 50, errorBuilder: (c,e,s) => Icon(Icons.store)),
                   ),
                   SizedBox(height: 10),
                   Text('Welcome User', style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
            ListTile(leading: Icon(FeatherIcons.home), title: Text('Home'), onTap: () {}),
            ListTile(leading: Icon(FeatherIcons.grid), title: Text('Categories'), onTap: () {}),
            ListTile(leading: Icon(FeatherIcons.heart), title: Text('Favourites'), onTap: () {}),
            ListTile(leading: Icon(FeatherIcons.shoppingCart), title: Text('My Cart'), onTap: () {}),
          ],
        ),
      ),

      // 3. Simple Body with SingleScrollView
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            
            // Banner Carousel
            BannerCarousel(banners: banners),
            
            SizedBox(height: 10),
            
            // Category Grid
            CategoryGrid(categories: categories),
            
            SizedBox(height: 10),
            
            // Product Sections
            BannerProductSection(
              title: "Ultra Fresh",
              banner: {'uri': 'https://g-cdn.blinkco.io/ordering-system/55544/splash/1742625689.jpg'},
              products: [
                { 'id': 'p1', 'title': 'Fresh Mutton Mix',    'price': 2399, 'image': 'https://em-cdn.eatmubarak.pk/55544/gallery/MENU%20BONELESS%20HANDI%20500GM.png' },
                { 'id': 'p2', 'title': 'Fresh Cauliflower',   'price': 49,   'image': 'https://images.unsplash.com/photo-1540420773420-3366772f4999?q=80&w=800', 'badge': 'Best Seller' },
                { 'id': 'p3', 'title': 'Fresh Beef With Bone', 'price': 1299, 'image': 'https://images.unsplash.com/photo-1544025162-d76694265947?q=80&w=800' },
                { 'id': 'p4', 'title': 'Tomatoes (1kg)',      'price': 119,  'image': 'https://images.unsplash.com/photo-1546470428-2b4f1a2c641c?q=80&w=800' },
              ],
              onAddToCart: (item) => appState.addToCart(Map<String, dynamic>.from(item)),
            ),

            BannerProductSection(
              title: "Grocery",
              banner: {'uri': 'https://g-cdn.blinkco.io/ordering-system/55544/splash/1744283878.jpg'},
              products: [
                { 'id': 'g1', 'title': 'Atta 10kg',       'price': 1999, 'image': 'https://em-cdn.eatmubarak.pk/55544/gallery/MENU%20BONELESS%20HANDI%20500GM.png' },
                { 'id': 'g2', 'title': 'Cooking Oil 3L',  'price': 2450, 'image': 'https://em-cdn.eatmubarak.pk/55544/gallery/MENU%20BONELESS%20HANDI%20500GM.png' },
                { 'id': 'g3', 'title': 'Sugar 5kg',       'price': 720,  'image': 'https://images.unsplash.com/photo-1615485921621-43ad2825d3cf?q=80&w=800' },
                { 'id': 'g4', 'title': 'Rice 5kg',        'price': 1850, 'image': 'https://images.unsplash.com/photo-1517685352821-92cf88aee5a5?q=80&w=800' },
              ],
              onAddToCart: (item) => appState.addToCart(Map<String, dynamic>.from(item)),
            ),

            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// WIDGET: BANNER CAROUSEL
// ==========================================
class BannerCarousel extends StatelessWidget {
  final List<dynamic> banners;
  
  const BannerCarousel({Key? key, required this.banners}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (banners.isEmpty) return SizedBox.shrink();
    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 4),
      ),
      items: banners.map((banner) {
         return Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(banner['uri']), // Simple NetworkImage
                fit: BoxFit.cover,
              ),
            ),
         );
      }).toList(),
    );
  }
}

// ==========================================
// WIDGET: CATEGORY GRID
// ==========================================
class CategoryGrid extends StatelessWidget {
  final List<dynamic> categories;
  // Simple colors
  final List<Color> pastelColors = [
    Color(0xFFE3F2FD), Color(0xFFE8F5E9), Color(0xFFFFF3E0), Color(0xFFF3E5F5),
    Color(0xFFFCE4EC), Color(0xFFFFF8E1)
  ];

  CategoryGrid({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return SizedBox.shrink();

    // Show top 8
    final items = categories.take(8).toList();
    final width = MediaQuery.of(context).size.width;
    final itemWidth = (width - 32 - 12) / 4; // 4 items per row

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Shop By Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Wrap(
            spacing: 4,
            runSpacing: 12,
            children: items.asMap().entries.map((entry) {
              final idx = entry.key;
              final cat = entry.value;
              return Container(
                width: itemWidth,
                child: Column(
                  children: [
                    Container(
                      height: itemWidth * 0.8,
                      width: itemWidth * 0.8,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: pastelColors[idx % pastelColors.length],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: cat['image'],
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Center(child: Icon(Icons.image, size: 20, color: Colors.grey)),
                        errorWidget: (context, url, error) => Icon(Icons.error, size: 20),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(cat['title'], style: TextStyle(fontSize: 11), textAlign: TextAlign.center, maxLines: 2),
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

// ==========================================
// WIDGET: BANNER PRODUCT SECTION
// ==========================================
class BannerProductSection extends StatefulWidget {
  final String title;
  final Map<String, dynamic>? banner;
  final List<dynamic> products;
  final Function(dynamic)? onAddToCart;

  const BannerProductSection({
    Key? key,
    required this.title,
    this.banner,
    required this.products,
    this.onAddToCart,
  }) : super(key: key);

  @override
  State<BannerProductSection> createState() => _BannerProductSectionState();
}

class _BannerProductSectionState extends State<BannerProductSection> {
  // Simple Modal for Quantity
  void _openProductModal(BuildContext context, dynamic item) {
    int qty = 1;
    final double price = (item['price'] as num).toDouble();

    // Using standard built-in showModalBottomSheet for simplicity
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.all(20),
              height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['title'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: item['image'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rs ${price * qty}', style: TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(FeatherIcons.minusCircle),
                                onPressed: () {
                                  if (qty > 1) setState(() => qty--);
                                },
                              ),
                              Text('$qty', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: Icon(FeatherIcons.plusCircle),
                                onPressed: () {
                                  setState(() => qty++);
                                },
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      onPressed: () {
                        widget.onAddToCart?.call({...item, 'qty': qty});
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added to cart!')));
                      },
                      child: Text('Add to Cart', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  )
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('View All', style: TextStyle(color: Theme.of(context).primaryColor)),
            ],
          ),
        ),

        // Section Banner
        if (widget.banner != null)
           Padding(
             padding: EdgeInsets.symmetric(horizontal: 16),
             child: ClipRRect(
               borderRadius: BorderRadius.circular(12),
               child: CachedNetworkImage(
                 imageUrl: widget.banner!['uri'],
                 height: 100,
                 width: double.infinity,
                 fit: BoxFit.cover,
               ),
             ),
           ),
        
        SizedBox(height: 10),

        // Products Horizontal List
        Container(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              return ProductCard(
                item: widget.products[index],
                onAdd: () => _openProductModal(context, widget.products[index]),
              );
            },
          ),
        )
      ],
    );
  }
}

// ==========================================
// WIDGET: PRODUCT CARD
// ==========================================
class ProductCard extends StatelessWidget {
  final dynamic item;
  final VoidCallback onAdd;

  const ProductCard({Key? key, required this.item, required this.onAdd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: EdgeInsets.only(right: 12, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Stack(
              children: [
                 Container(
                   height: 110,
                   width: double.infinity,
                   color: Colors.grey[100],
                   child: CachedNetworkImage(
                     imageUrl: item['image'],
                     fit: BoxFit.contain,
                     placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                     errorWidget: (context, url, err) => Icon(Icons.error),
                   ),
                 ),
                 if (item['badge'] != null)
                  Positioned(
                    top: 8, left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      color: Colors.amber,
                      child: Text(item['badge'], style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  )
              ],
            ),
          ),
          
          // Details
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['title'], maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Rs ${item['price']}', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                    
                    // Circular Add Button
                    InkWell(
                      onTap: onAdd,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
                        child: Icon(Icons.add, color: Colors.white, size: 16),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
