import 'package:flashchat/Tmart/screens/home.dart';
import 'package:flashchat/Tmart/widgets/product_card/grid_layout.dart';
import 'package:flashchat/Tmart/widgets/product_card/product_card_vertical.dart';
import 'package:flutter/material.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Wishlist',style: TextStyle(fontSize:20,fontWeight: FontWeight.w800),),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>const Home(),
                ),
              );
            },
            icon: const Icon(Icons.add),color: Colors.black,),
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            TGridLayout(itemCount: 6,
                itemBuilder: (_,context)=>const TProductCardVertical()),
          ],
        )
      ),
    );
  }
}
