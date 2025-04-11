import 'package:flashchat/Tmart/colors.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/button.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/circular_icon.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/rounded_container.dart';
import 'package:flutter/material.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
     padding: EdgeInsets.symmetric(horizontal:12,vertical:4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TCircularIcon(icon:Icons.remove,backgroundColor: Colors.grey,color: Colors.white,),
              SizedBox(width: 6,),
              Text('2',style: Theme.of(context).textTheme.titleMedium,),
              SizedBox(width: 6,),
              TCircularIcon(icon:Icons.add,backgroundColor: Colors.grey,color: Colors.white,),
            ],
          ),
          TButton(onTap: (){}, width: 120, height:40,text:'Add to cart'),
        ],
      ),
    );
  }
}
