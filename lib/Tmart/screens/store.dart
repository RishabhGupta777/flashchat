import 'package:flashchat/Tmart/brand_service.dart';
import 'package:flashchat/Tmart/colors.dart';
import 'package:flashchat/Tmart/help.dart';
import 'package:flashchat/Tmart/screens/all_brand_screen.dart';
import 'package:flashchat/Tmart/screens/brand_products.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/cart_counter_icon.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/category_tab.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/section_heading.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/t_search_container.dart';
import 'package:flashchat/Tmart/widgets/product_card/grid_layout.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/brand_card.dart';
import 'package:flutter/material.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar:AppBar(
          title: const Text('Store',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: TColors.primary),),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TCartCounterIcon(iconColor: TColors.primary,),
            ),
          ],
        ),
        body:  NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  floating: true,
                  pinned: true,  //<--isi se Tabbar pin hua h
                  snap: true,
                  expandedHeight: 340.0,
                  forceElevated: innerBoxIsScrolled,
                  backgroundColor: Colors.white,
                  flexibleSpace:ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const TSearchContainer(enableBorderColor: Colors.black12,focusBorderColor: Colors.black12,),
                      const SizedBox(height: 10,),
                       TSectionHeading(title:"Featured Brands",onPressed: ()async{
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>AllBrandScreen()));
                      }, ),
                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: getAllBrands(limit: 3), // limit to 2 brands
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return const CircularProgressIndicator();

                          final brands = snapshot.data!;
                          return TGridLayout(
                            itemCount: brands.length,
                            mainAxisExtent: 76,
                            itemBuilder: (_, index) {
                              final brand = brands[index];
                              return TBrandCard(
                                showBorder: true,
                                brandName: brand['name'],
                                brandLogo: brand['logo'],
                                totalItems: brand['totalItems'],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BrandProducts(
                                        brandName: brand['name'],
                                        brandLogo: brand['logo'],
                                        totalItems: brand['totalItems'],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      )


                    ],
                  ),
                  bottom:  PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight),
                    child: Container(
                      color: Colors.white, // Change this to your desired background color
                      child: const TabBar(
                        isScrollable: true,
                        indicatorColor: TColors.primary,
                        unselectedLabelColor: Colors.grey,
                        labelColor: TColors.primary,
                        tabs: [
                          Tab(child: Text("Shoes")),
                          Tab(child: Text("Electronics")),
                          Tab(child: Text("Clothes")),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body:  TabBarView(
            children:[
              ///shoes category
             TCategoryTab(category: "shoes"),
              ///Electronics category
              TCategoryTab(category: "electronics",),
              ///Clothes category
              TCategoryTab(category: "clothes",),

            ],
          ),
        ),

      ),
    );
  }
}

