import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WishlistService {
  static final _userId = FirebaseAuth.instance.currentUser?.uid;

  static Future<bool> checkIfWishlisted(String productId) async {
    final doc = await FirebaseFirestore.instance
        .collection('wishlists')
        .doc(_userId)
        .collection('items')
        .doc(productId)
        .get();

    return doc.exists;
  }

  static Future<void> toggleWishlist(DocumentSnapshot productDoc, bool currentlyWishlisted) async {
    final docId = productDoc.id;
    final itemRef = FirebaseFirestore.instance
        .collection('wishlists')
        .doc(_userId)
        .collection('items')
        .doc(docId);

    if (currentlyWishlisted) {
      await itemRef.delete();
    } else {
      await itemRef.set(productDoc.data() as Map<String, dynamic>);
    }
  }
}
