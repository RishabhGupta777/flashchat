import 'package:flutter/material.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/rounded_container.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/product_title_text.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/product_price_text.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/brand_name.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({
    super.key,
   required this.name,
   required this.price,
   required this.brand,
    required this.brandLogo,

  });
  final String name;
  final String  price;
  final String  brand;
  final String  brandLogo;




  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TRoundedContainer(
              backgroundColor: Colors.amber,
              padding: 6,
              radius: 10,
              child: Text(" 25% ",style: Theme.of(context).textTheme.labelLarge!,),
            ),
            SizedBox(width: 10),
            Text("₹250",style: Theme.of(context).textTheme.titleSmall!.apply(decoration:TextDecoration.lineThrough),),
            SizedBox(width: 10),
            TProductPriceText(price: price),
          ],
        ),
        SizedBox(height: 5),

        ///Title
        TProductTitleText(
            isLarge: false,
            title: name,
        ),
        SizedBox(height: 5),

        ///Stock Status
        Row(
          children: [
            Text('Status'),
            SizedBox(width:8),
            TProductTitleText(isLarge: false, title: 'In Stock'),
          ],
        ),
        SizedBox(height: 5),
        ///Brand
        Row(
          children: [
            TRoundedContainer(
              height: 30,
              radius:0,
              child:Image.network(
                brandLogo,
                fit: BoxFit.cover, // Ensures it fills the rounded shape properly
              ),
            ),
            SizedBox(width: 2,),
            TBrandName(title: brand),
          ],
        ),

      ],
    );
  }
}

