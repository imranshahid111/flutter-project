import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/login_screen.dart';
import 'services/firebase_service.dart';
import 'firebase_options.dart';
import 'components/common_image.dart';
import 'data/static_data.dart';

// ==========================================
// MAIN ENTRY POINT
// ==========================================
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    print('Starting Firebase Initialization...');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ); 
    print('Firebase Initialized Successfully');
  } catch (e) {
    print('Firebase Initialization Failed: $e');
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        Provider(create: (_) => FirebaseService()),
      ],
      child: MyApp(),
    ),
  );
}

// ==========================================
// MAIN APPLICATION WIDGET & AUTH GATE
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
        fontFamily: 'Roboto',
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.hasData) {
            return HomeScreen();
          }
          return LoginScreen();
        },
      ),
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Rubaika'),
        actions: [
          IconButton(
            icon: Icon(FeatherIcons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(FeatherIcons.logOut),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(FeatherIcons.shoppingCart),
                onPressed: () {
                   // Navigate to cart
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
                   Text(FirebaseAuth.instance.currentUser?.email ?? 'Welcome User', style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),
            ListTile(leading: Icon(FeatherIcons.home), title: Text('Home'), onTap: () {}),
            ListTile(leading: Icon(FeatherIcons.grid), title: Text('Categories'), onTap: () {}),
            ListTile(leading: Icon(FeatherIcons.power), title: Text('Logout'), onTap: () => FirebaseAuth.instance.signOut()),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            
            // Banner Carousel
            BannerCarousel(banners: StaticData.banners),
            
            SizedBox(height: 10),
            
            // Category Grid
            CategoryGrid(categories: StaticData.categories),
            
            SizedBox(height: 10),
            
            // Product Sections
            BannerProductSection(
              title: "Ultra Fresh",
              banner: {'uri': 'https://g-cdn.blinkco.io/ordering-system/55544/splash/1742625689.jpg'},
              products: StaticData.freshProducts,
              onAddToCart: (item) => appState.addToCart(Map<String, dynamic>.from(item)),
            ),

            BannerProductSection(
              title: "Grocery",
              banner: {'uri': 'https://g-cdn.blinkco.io/ordering-system/55544/splash/1744283878.jpg'},
              products: StaticData.groceryProducts,
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CommonImage(
                imageUrl: banner['uri'] ?? '',
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
                      child: CommonImage(
                        imageUrl: cat['image'] ?? '',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(cat['title'] ?? '', style: TextStyle(fontSize: 11), textAlign: TextAlign.center, maxLines: 2),
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
                  Text(item['title'] ?? 'Product', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CommonImage(
                          imageUrl: item['image'] ?? '',
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
               child: CommonImage(
                 imageUrl: widget.banner!['uri'] ?? '',
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
                   child: CommonImage(
                     imageUrl: item['image'] ?? '',
                     fit: BoxFit.contain,
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
                Text(item['title'] ?? 'Product', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Rs ${item['price'] ?? 0}', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                    
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
