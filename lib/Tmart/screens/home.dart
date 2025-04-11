import 'package:flashchat/Tmart/colors.dart';
import 'package:flashchat/Tmart/screens/all_product.dart';
import 'package:flashchat/Tmart/screens/cart_screen.dart';
import 'package:flashchat/Tmart/screens/sub_Categories_screen.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/banner_slider.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/cart_counter_icon.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/rounded_container.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/section_heading.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/t_search_container.dart';
import 'package:flashchat/Tmart/widgets/product_card/grid_layout.dart';
import 'package:flashchat/Tmart/widgets/product_card/product_card_vertical.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: TColors.primary,
              padding: const EdgeInsets.all(0),
              child:SizedBox(
                height:310,
                child: Stack(  //this Widget allow stack elements on top of each other
                  children: [
                    Positioned(top:-150,right:-250,child: TRoundedContainer(height:400,width:400,radius:400,backgroundColor: TColors.textWhite.withOpacity(0.1),)),
                    Positioned(top:100,right:-300,child: TRoundedContainer(height:400,width:400,radius:400,backgroundColor: TColors.textWhite.withOpacity(0.1),)),
                    Positioned(
                      top: 2,
                      left: 0,
                      right: 0,
                      child: AppBar(
                        title: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Good day for shoping",style: TextStyle(fontSize: 14,color: Colors.white),),
                            Text("Rishabh Gupta",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),)
                          ],
                        ),
                        backgroundColor: TColors.primary.withOpacity(0.0),
                        elevation: 0,
                        actions: [
                          TCartCounterIcon(onPressed:(){
                            Navigator.push(context, MaterialPageRoute(builder:(context)=>CartScreen()));
                          }),
                          SizedBox(width: 10,)
                        ],
                      ),
                    ),
                    const Positioned(
                      top: 100,
                      left: 0,
                      right: 0,
                      child: TSearchContainer(),
                    ),
                    Positioned(
                      top: 180,
                      left: 0,
                      right: 0,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left:15.0),
                            child: Text('Popular Categories',style:TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.white)),
                          ),
                          const SizedBox(height:10),
                         SizedBox(
                           height:82,
                           child: ListView.builder(
                             scrollDirection: Axis.horizontal,
                             shrinkWrap: true,
                             itemCount: 6,
                             itemBuilder: (BuildContext context, int index) {
                               return TVerticalImageText(
                                 onTap:()=> Navigator.push(context, MaterialPageRoute(builder:(context)=>SubCategoriesScreen())),);
                             }
                           ),
                         ),
                        ],
                      )

                  )
                  ],
                ),
              ),
            ),
            const BannerSlider(),
          SizedBox(height: 2,),
          TSectionHeading(title: 'Popular Products', onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder:(context)=>AllProduct())),),
          TGridLayout(itemCount: 6,
              itemBuilder:    (_, int index) {
            return const TProductCardVertical();
          },),
          ],
        ),
      ),
    );
  }
}

class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key,
    this.onTap,
  });
  final Function() ? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Padding(
        padding: EdgeInsets.only(right:9,left: 15),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/images/shoes/black.png"),
            ),
            SizedBox(height: 2,),
            SizedBox(
              width:55,
              child: Text(
                  'Nike Shoes',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

