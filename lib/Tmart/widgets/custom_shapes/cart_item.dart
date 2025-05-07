import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/Tmart/screens/product_detail.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/brand_name.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/circular_icon.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/product_price_text.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/product_quantity_with_add_remove_button.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/product_title_text.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/rounded_container.dart';
import 'package:flutter/material.dart';

class TCartItem extends StatefulWidget {
  final DocumentSnapshot ? document;
  const TCartItem({super.key, this.document,});

  @override
  State<TCartItem> createState() => _TCartItemState();
}

class _TCartItemState extends State<TCartItem> {
  @override
  Widget build(BuildContext context) {
    final data = widget.document!.data() as Map<String, dynamic>;
    final name = data['name'] ?? '';
    final brand = data['brand'] ?? '';

    final variations = List<Map<String, dynamic>>.from(data['variation'] ?? []);
    final variation = variations[0];
    final imageUrl=variation['pic'];
    final price=variation['price'];

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
          width: 310,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.black12,
          ),
          child:Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TRoundedContainer(
                          height: 100,
                          width: 100,
                          radius: 15,
                          child:Image.network(imageUrl, height: 100, fit: BoxFit.cover,),),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color:Colors.black,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          )
                      ),
                      child: SizedBox(
                        height: 35,
                        width: 116,
                        child: GestureDetector(
                          onTap:(){
                            FirebaseFirestore.instance
                                .collection('cartlists')
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .collection('items')
                                .doc(widget.document!.id)
                                .delete();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete_outline,color: Colors.white,),
                              SizedBox(width: 5,),
                              Text('remove',style:TextStyle(color: Colors.white),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left:20.0,top:8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SizedBox(
                            width:136,
                            child: TProductTitleText(title:name,isLarge:false,),),
                      ),
                      SizedBox(height: 3,),
                      TBrandName(title: brand,),
                      SizedBox(height:3,),
                      TProductPriceText(price:price,isLarge: false,),
                      SizedBox(height:3,),
                      TProductQuantityWithAddRemoveButton(),
                    ],
                  ),
                )
              ]
          )
      ),
    );
  }
}
