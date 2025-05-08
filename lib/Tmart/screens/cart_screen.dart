import 'package:flashchat/Tmart/screens/check_out_screen.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/button.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/cart_items.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart',style: TextStyle(fontSize:20,fontWeight: FontWeight.w800)),
      ),
      body:TCartItems(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('₹999'),
            TButton(onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Checkoutscreen(),));
            },height:40,width:170,radius :8,text:'Place Order',),
          ],
        ),
      ),
    );
  }
}


