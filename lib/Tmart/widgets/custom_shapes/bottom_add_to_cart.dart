import 'package:flashchat/Tmart/colors.dart';
import 'package:flashchat/Tmart/screens/cart_screen.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/button.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/Tmart/screens/check_out_screen.dart';


class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TButton(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
            },
              radius: 0.0,
              width:double.infinity,
              height:60,
              text:'Add to cart',
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Checkoutscreen()));
            },
              text:'Buy now',
            ),
          ),
        ],
      ),
    );
  }
}
