import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/Tmart/screens/product_detail.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/brand_name.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/circular_icon.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/product_price_text.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/product_title_text.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/rounded_container.dart';
import 'package:flashchat/Tmart/wishlist_service.dart';
import 'package:flutter/material.dart';

class TProductCardVertical extends StatefulWidget {
  const TProductCardVertical({
    super.key,
   this.document,
  });
  final DocumentSnapshot ? document;

  @override
  State<TProductCardVertical> createState() => _TProductCardVerticalState();
}

class _TProductCardVerticalState extends State<TProductCardVertical> {
  bool isWishlisted = false;

  @override
  void initState() {
    super.initState();
    WishlistService.checkIfWishlisted(widget.document!.id).then((exists) {
      if (exists) {
        setState(() {
          isWishlisted = true;
        });
      }
    });
  }

  Future<void> toggleWishlist() async {
    await WishlistService.toggleWishlist(widget.document!, isWishlisted);
    setState(() {
      isWishlisted = !isWishlisted;
    });
  }


  @override
  Widget build(BuildContext context) {
    final data = widget.document!.data() as Map<String, dynamic>;
    final name = data['name'] ?? '';
    final imageUrl = (data['pic'] as List).isNotEmpty ? data['pic'][0] : '';
    final price = data['price'] ?? '';
    final brand = data['brand'] ?? '';


    return GestureDetector(
      onTap: (){
        Navigator.push( context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              document : widget.document!
            ),
          ),);
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black12,
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  TRoundedContainer(
                    height: 150,
                    width: 150,
                    radius: 15,
                    child: Image.network(imageUrl, height: 100, fit: BoxFit.cover),),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                        padding:const EdgeInsets.symmetric(horizontal:3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.yellow,
                        ),
                        child: const Text('25%',style:TextStyle(fontWeight:FontWeight.w300))
                    ),
                  ),
                  Positioned(
                    top:2,
                    right: 2,
                    child: TCircularIcon(
                      onTap: toggleWishlist,
                      icon: isWishlisted ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductTitleText(title:name,isLarge:false,),
                  SizedBox(height: 5,),
                  TBrandName(title: brand,),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left:14),
                  child: TProductPriceText(price:price,isLarge: false,),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color:Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      )
                  ),
                  child: const SizedBox(
                      height: 40,
                      width: 40,
                      child: Icon(Icons.add,color: Colors.white,)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}





