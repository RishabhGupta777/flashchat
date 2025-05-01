import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashchat/Tmart/screens/check_out_screen.dart';
import 'package:flashchat/Tmart/screens/product_reviews.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/bottom_add_to_cart.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/button.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/product_attributes.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/product_image_slider.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/product_meta_data.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/rating_and_share.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/section_heading.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/text_read_more.dart';
import 'package:flutter/material.dart';


class ProductDetailScreen extends StatefulWidget {

  final DocumentSnapshot  document;
  const ProductDetailScreen({super.key,required this.document});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final data = widget.document.data() as Map<String, dynamic>;
    final name = data['name'] ?? '';
    final brand = data['brand'] ?? '';
    final price = data['price'] ?? '';
    final brandLogo = data['brandLogo'] ?? '';
    final images = List<String>.from(data['pic'] ?? []);


    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(),
      body:SingleChildScrollView(
        child:Column(
          children: [
            ///product image slider
            TProductImageSlider(images: images),

            ///Rating and Share button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  TRatingAndShare(),
                  
                  TProductMetaData(
                    brand: brand,
                    name:name,
                    price:price,
                    brandLogo:brandLogo,
                  ),

                  ProductAttributes(),
                  SizedBox(height: 8,),

                  ///checkOut Button
                  TButton(width:double.infinity ,height:45,onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Checkoutscreen()));
                  },text:'CheckOut',),
                  SizedBox(height: 8),


                  TSectionHeading(title: 'Discription' ,showActionButton: false,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextReadMore(
                      text:'This is a Product description for Blue Nike Sleeve less vest.There are more things that can be added but i am unable to add then due to lack of space     ',
                    ),
                  ),

                  ///Reviews
                  Divider(),
                  InkWell(
                    onTap:()=>  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductReviewsScreen())),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TSectionHeading(title: 'Reviews (199)',showActionButton: false,),
                        Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),

          ],
        ),
      )
    );
  }
}


