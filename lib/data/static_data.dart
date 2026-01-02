
class StaticData {
  static const List<Map<String, dynamic>> banners = [
    // Shopping bag with veggies
    {'id': '1', 'uri': 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=1000&q=80'},
    // Supermarket aisle
    {'id': '2', 'uri': 'https://images.unsplash.com/photo-1578916171728-46686eac8d58?auto=format&fit=crop&w=1000&q=80'},
    // Fresh produce
    {'id': '3', 'uri': 'https://images.unsplash.com/photo-1610348725531-843dff563e2c?auto=format&fit=crop&w=1000&q=80'},
  ];

  static const List<Map<String, dynamic>> categories = [
    {'id': '1', 'title': 'Fresh Fruits', 'image': 'https://cdn.dummyjson.com/product-images/groceries/apple/1.webp', 'order': 1},
    {'id': '2', 'title': 'Vegetables', 'image': 'https://cdn.dummyjson.com/product-images/groceries/green-bell-pepper/1.webp', 'order': 2},
    {'id': '3', 'title': 'Dairy & Eggs', 'image': 'https://cdn.dummyjson.com/product-images/groceries/milk/1.webp', 'order': 3},
    {'id': '4', 'title': 'Bakery', 'image': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=400&q=80', 'order': 4},
    {'id': '5', 'title': 'Meat & Poultry', 'image': 'https://cdn.dummyjson.com/product-images/groceries/chicken-meat/1.webp', 'order': 5},
    {'id': '6', 'title': 'Seafood', 'image': 'https://cdn.dummyjson.com/product-images/groceries/fish-steak/1.webp', 'order': 6},
    {'id': '7', 'title': 'Beverages', 'image': 'https://cdn.dummyjson.com/product-images/groceries/juice/1.webp', 'order': 7},
    {'id': '8', 'title': 'Snacks', 'image': 'https://cdn.dummyjson.com/product-images/groceries/ice-cream/1.webp', 'order': 8},
  ];

  static const List<Map<String, dynamic>> freshProducts = [
    {
      'id': '101', 
      'title': 'Fresh Strawberries 500g', 
      'price': 450, 
      'image': 'https://cdn.dummyjson.com/product-images/groceries/strawberry/1.webp', 
      'badge': 'Fresh'
    },
    {
      'id': '102', 
      'title': 'Organic Bananas 1 Dozen', 
      'price': 200, 
      'image': 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?auto=format&fit=crop&w=400&q=80', 
      'badge': 'Best Seller'
    },
    {
      'id': '103', 
      'title': 'Red Apples 1kg', 
      'price': 350, 
      'image': 'https://cdn.dummyjson.com/product-images/groceries/apple/1.webp'
    },
     {
      'id': '104', 
      'title': 'Green Grapes 500g', 
      'price': 400, 
      'image': 'https://images.unsplash.com/photo-1537640538965-1756e9e43ea9?auto=format&fit=crop&w=400&q=80'
    },
  ];

  static const List<Map<String, dynamic>> groceryProducts = [
    {
      'id': '201', 
      'title': 'Whole Wheat Bread', 
      'price': 150, 
      'image': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=400&q=80',
      'badge': 'Healthy'
    },
    {
      'id': '202', 
      'title': 'Farm Fresh Eggs 1 Dozen', 
      'price': 320, 
      'image': 'https://cdn.dummyjson.com/product-images/groceries/eggs/1.webp'
    },
    {
      'id': '203', 
      'title': 'Pure Milk 1L', 
      'price': 220, 
      'image': 'https://cdn.dummyjson.com/product-images/groceries/milk/1.webp'
    },
    {
      'id': '204', 
      'title': 'Basmati Rice 1kg', 
      'price': 450, 
      'image': 'https://cdn.dummyjson.com/product-images/groceries/rice/1.webp'
    },
  ];
}
