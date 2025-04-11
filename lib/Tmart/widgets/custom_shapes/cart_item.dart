import 'package:flutter/material.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/brand_name.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/product_title_text.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/rounded_container.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Image
        TRoundedContainer(
          width: 60,
          height:60,
          radius:0,
          backgroundColor: Colors.white,
          child:Image.asset('assets/images/shoes/brown.png',fit: BoxFit.contain,),
        ),
        SizedBox(width:7),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TBrandName(title: 'Nike',),
            SizedBox(width:250,child: TProductTitleText(title:'Black Sports shoes New classic no.1 for you',isLarge: false,)),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Color ', style: Theme.of(context).textTheme.bodySmall,),
                  TextSpan(text: 'Green ', style: Theme.of(context).textTheme.bodyLarge,),
                  TextSpan(text: 'Size ', style: Theme.of(context).textTheme.bodySmall,),
                  TextSpan(text: 'UK 08', style: Theme.of(context).textTheme.bodyLarge,),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height:15),
      ],
    );
  }
}

