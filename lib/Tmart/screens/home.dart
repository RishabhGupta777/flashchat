import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashchat/Tmart/colors.dart';
import 'package:flashchat/Tmart/firestore_service.dart';
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
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> categories = [];


  @override
  void initState() {
    super.initState();
    loadCategories();
    loadProducts();
  }

  Future<void> loadProducts() async {
    final loadedProducts = await FirestoreService.fetchCollection('Products');
    setState(() {
      products = loadedProducts;
    });
  }
  Future<void> loadCategories() async {
    final loadedProducts = await FirestoreService.fetchCollection('category');
    setState(() {
      categories = loadedProducts;
    });
  }


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
                             itemCount: categories.length,
                             itemBuilder: (BuildContext context, int index) {
                               final category = categories[index];
                               return TVerticalImageText(
                                 name:category['name'],
                                 imageUrl:category['pic'],
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
    StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('Products').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

      final products = snapshot.data!.docs;

      return TGridLayout(
        itemCount: products.length,
        itemBuilder: (_, int index) {
          final product = products[index];
          return TProductCardVertical(
            document: product,
          );
        },
      );
    }
    )

          ],
        ),
      ),
    );
  }
}

class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key,
    this.name=" ",
    this.imageUrl=" ",
    this.onTap,
  });
  final String name;
  final String imageUrl;
  final Function() ? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right:9,left: 15),
        child: Column(
          children: [
            TRoundedContainer(
              radius: 60,
              height: 60,
              width: 60,
              backgroundColor: Colors.white,
              child:  Image.network(imageUrl, height: 100, fit: BoxFit.cover),
            ),
            SizedBox(height: 2,),
            SizedBox(
              width:55,
              child: Text(
                  name,
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

