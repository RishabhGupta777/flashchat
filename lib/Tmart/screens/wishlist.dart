import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/Tmart/screens/home.dart';
import 'package:flashchat/Tmart/widgets/product_card/grid_layout.dart';
import 'package:flashchat/Tmart/widgets/product_card/product_card_vertical.dart';
import 'package:flutter/material.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title:const Text('Wishlist',style: TextStyle(fontSize:20,fontWeight: FontWeight.w800),),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>const Home(),
                ),
              );
            },
            icon: const Icon(Icons.add),color: Colors.black,),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('wishlists')
        .doc(userId)
        .collection('items')
        .snapshots(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator());
    }

    final wishlistDocs = snapshot.data?.docs ?? [];

    if (wishlistDocs.isEmpty) {
    return const Center(child: Text('Your wishlist is empty.'));
    }

    return SingleChildScrollView(
    physics: const NeverScrollableScrollPhysics(),
    child: Column(
    children: [
    TGridLayout( itemCount: wishlistDocs.length,
    itemBuilder: (_,int index)=>TProductCardVertical(document: wishlistDocs[index])),
    ],
    )
    );
    }
      )
    );
  }
}
