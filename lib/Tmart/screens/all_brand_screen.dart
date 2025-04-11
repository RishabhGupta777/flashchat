import 'package:flashchat/Tmart/screens/brand_products.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/brand_card.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/section_heading.dart';
import 'package:flashchat/Tmart/widgets/product_card/grid_layout.dart';
import 'package:flutter/material.dart';

class AllBrandScreen extends StatelessWidget {
  const AllBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brand'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Heading
            const TSectionHeading(title: 'Brands', showActionButton: false),
            const SizedBox(height:10),

            /// Brands
            TGridLayout(
              itemCount: 10,
              mainAxisExtent: 80,
              itemBuilder: (context, index) =>
             TBrandCard(
                  showBorder: true,
                onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BrandProducts()));
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
