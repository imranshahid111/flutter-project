import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];
  List<Map<String, dynamic>> _favourites = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;
  List<Map<String, dynamic>> get favourites => _favourites;

  int get cartCount => _cartItems.length;

  // Cart
  void addToCart(Map<String, dynamic> item) {
    // Check if exists
    final index = _cartItems.indexWhere((i) => i['id'] == item['id']);
    if (index >= 0) {
      // Update qty
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

  void updateCartQty(String id, int qty) {
    final index = _cartItems.indexWhere((item) => item['id'] == id);
    if (index >= 0) {
      if (qty <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index]['qty'] = qty;
      }
      notifyListeners();
    }
  }

  double get subtotal => _cartItems.fold(0, (sum, item) => sum + (item['price'] * item['qty']));
  double get delivery => (subtotal >= 3000 || subtotal == 0) ? 0 : 199;
  double get total => subtotal + delivery;

  // Favourites
  void toggleFavourite(Map<String, dynamic> item) {
    final index = _favourites.indexWhere((i) => i['id'] == item['id']);
    if (index >= 0) {
      _favourites.removeAt(index);
    } else {
      _favourites.add(item);
    }
    notifyListeners();
  }
  
  bool isFavourite(String id) {
    return _favourites.any((item) => item['id'] == id);
  }
}
