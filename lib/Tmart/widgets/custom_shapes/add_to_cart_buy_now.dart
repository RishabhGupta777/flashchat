import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/Tmart/colors.dart';
import 'package:flashchat/Tmart/screens/cart_screen.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/button.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/Tmart/screens/check_out_screen.dart';


class TAddToCartBuyNow extends StatefulWidget {

  final DocumentSnapshot ? document;
  final int selectedVariationIndex;
  const TAddToCartBuyNow({super.key, this.document,this.selectedVariationIndex=0});

  @override
  State<TAddToCartBuyNow> createState() => _TAddToCartBuyNowState();
}

class _TAddToCartBuyNowState extends State<TAddToCartBuyNow> {
  static final _userId = FirebaseAuth.instance.currentUser?.uid;
  bool isCartListed=false;
  @override
  void initState() {
    super.initState();
    checkIfCartListed();
  }
  // Check if the item is in the cart
  Future<void> checkIfCartListed() async {
    if (_userId == null || widget.document == null) return; // null check for user and document

    final doc = await FirebaseFirestore.instance
        .collection('cartlists')
        .doc(_userId)
        .collection('items')
        .doc(widget.document!.id)
        .get();

    if (doc.exists) {
      setState(() {
        isCartListed = true;
      });
    }

  }

  // Toggle the item between cart and wishlist
  Future<void> toggleCartList() async {
    if (_userId == null || widget.document == null) return; // null check for user and document

    final itemRef = FirebaseFirestore.instance
        .collection('cartlists')
        .doc(_userId)
        .collection('items')
        .doc(widget.document!.id);

    if (!isCartListed) {
      await itemRef.set(widget.document!.data() as Map<String, dynamic>);
      setState(() {
        isCartListed = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item Add to cart successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TButton(onTap: (){
            isCartListed ? Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen())) : toggleCartList();
            },
              radius: 0.0,
              width:double.infinity,
              height:60,
              text:isCartListed ?'Go to cart ' : 'Add to cart' ,
              backgroundColor: Colors.white,
              textColor: Colors.black,
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: TButton(
              radius: 0.0,
              width:double.infinity ,
              height:60,
              onTap:(){
                final data = widget.document!.data() as Map<String, dynamic>;
                final variations = List<Map<String, dynamic>>.from(data['variation'] ?? []);
                final selectedPrice = variations[widget.selectedVariationIndex]['price'];
                final totalPrice = double.tryParse(selectedPrice.toString()) ?? 0.0;
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Checkoutscreen(
                totalPrice: totalPrice,
                singleProduct: widget.document,
                selectedVariationIndex: widget.selectedVariationIndex,
              )));
            },
              text:'Buy now',
            ),
          ),
        ],
      ),
    );
  }
}
