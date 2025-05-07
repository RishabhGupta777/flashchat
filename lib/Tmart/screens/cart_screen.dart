import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/Tmart/screens/check_out_screen.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/button.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/cart_item.dart';
import 'package:flashchat/Tmart/widgets/product_card/grid_layout.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cart',style: TextStyle(fontSize:20,fontWeight: FontWeight.w800)),
      ),
      body:StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('cartlists')
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
                    TGridLayout(
                       crossAxisCount: 1,
                        mainAxisExtent:167,
                        itemCount: wishlistDocs.length,
                        itemBuilder: (_,int index)=>TCartItem(document: wishlistDocs[index])),
                  ],
                )
            );
          }
      ),
      bottomNavigationBar: TButton(onTap:(){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Checkoutscreen(),));
      },height:50,radius :0,text: 'CheckOut ₹999',),
    );
  }
}

