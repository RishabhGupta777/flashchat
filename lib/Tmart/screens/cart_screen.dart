import 'package:flashchat/Tmart/screens/check_out_screen.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/button.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/cart_items.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: TCartItems(),
      ),
      bottomNavigationBar: TButton(onTap:(){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Checkoutscreen(),));
      },height:50,radius :0,text: 'CheckOut ₹999',),
    );
  }
}

