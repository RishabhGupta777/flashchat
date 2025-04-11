import 'package:flashchat/Tmart/screens/product_detail.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/brand_name.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/circular_icon.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/product_price_text.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/product_title_text.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/rounded_container.dart';
import 'package:flutter/material.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push( context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(),
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
                    child:Image(image:AssetImage("assets/images/Sneaker.png",),fit: BoxFit.contain,)),
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
                    child: TCircularIcon(icon: Icons.favorite,color: Colors.red,),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal:12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductTitleText(title: "White Nike Air Shoe",isLarge:false,),
                  SizedBox(height: 5,),
                  TBrandName(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left:14),
                  child: TProductPriceText(price:"435",isLarge: false,),
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





