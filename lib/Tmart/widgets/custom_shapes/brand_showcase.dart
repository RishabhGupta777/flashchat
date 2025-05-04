import 'package:flashchat/Tmart/widgets/custom_shapes/brand_card.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/rounded_container.dart';

class TBrandShowcase extends StatelessWidget {
  const TBrandShowcase({
    super.key,
    required this.images,
  });
  final List<String>images;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      borderColor: Colors.black45,
      margin:8,
      backgroundColor: Colors.white,
      child:Column(
        children: [
          const TBrandCard(showBorder: false,brandName: 'Nike',brandLogo: "https://firebasestorage.googleapis.com/v0/b/jioos-3ae31.appspot.com/o/products%2FbrandPic%2Fb5.jpeg?alt=media&token=c490cb62-0407-40d1-bd52-b2214088416a",),
          Row(
              children: images.map((image)=>BrandTopImagesWidget(image,context)).toList()
          )
        ],
      ),

    );
  }

  Expanded BrandTopImagesWidget(String image,context) {
    return Expanded(
      child: TRoundedContainer(
        borderColor: Colors.white,
        height: 80,
        margin:10,
        child:Image(image:AssetImage(image),fit: BoxFit.contain,),
      ),
    );
  }
}
