import 'package:flashchat/Tmart/widgets/custom_shapes/brand_showcase.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/section_heading.dart';
import 'package:flashchat/Tmart/widgets/product_card/grid_layout.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/Tmart/widgets/product_card/product_card_vertical.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(   //yha Listview bhi rah sakta tha  ,the shrinkWrap=true , the physics
      child: Column(
        children: [
          const SizedBox(height:65,),
          const TBrandShowcase(images: ["assets/images/Sneaker.png","assets/images/shoe.png","assets/images/Sneaker.png"],),
          const SizedBox(height: 4,),
          const TSectionHeading(title: 'You might like'),
          TGridLayout(itemCount: 4,
              itemBuilder: (_,context)=>const TProductCardVertical()),
          const SizedBox(height: 4,),
        ],
      ),
    );
  }
}

