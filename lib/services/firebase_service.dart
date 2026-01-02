import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch Banners
  Future<List<Map<String, dynamic>>> fetchBanners() async {
    try {
      final snapshot = await _db.collection('banners').get();
      return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
    } catch (e) {
      if (e.toString().contains('permission-denied')) {
        print('Error fetching banners: Permission Denied. Check your Firestore Security Rules.');
      } else {
        print('Error fetching banners: $e');
      }
      return [];
    }
  }

  // Fetch Categories
  Future<List<Map<String, dynamic>>> fetchCategories() async {
    try {
      final snapshot = await _db.collection('categories').orderBy('order').get(); // Assuming 'order' field exists for sorting
      return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
    } catch (e) {
      // If order field doesn't exist, try getting without sort or handle error
       try {
        final snapshot = await _db.collection('categories').get();
        return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
       } catch (e2) {
         if (e2.toString().contains('permission-denied')) {
            print('Error fetching categories: Permission Denied. Check your Firestore Security Rules.');
         } else {
            print('Error fetching categories: $e2');
         }
         return [];
       }
    }
  }

  // Fetch Products by Category or Tag
  Future<List<Map<String, dynamic>>> fetchProducts(String collectionName) async {
    try {
      final snapshot = await _db.collection(collectionName).get();
       return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
    } catch (e) {
      if (e.toString().contains('permission-denied')) {
        print('Error fetching products from $collectionName: Permission Denied. Check your Firestore Security Rules.');
      } else {
        print('Error fetching products from $collectionName: $e');
      }
      return [];
    }
  }
  
  // Fetch Section Products (flexible)
  Future<List<Map<String, dynamic>>> fetchSectionProducts(String sectionId) async {
      try {
        final snapshot = await _db.collection('sections').doc(sectionId).collection('products').get();
        return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
      } catch (e) {
        print('Error fetching section products: $e');
        return [];
      }
  }
}
