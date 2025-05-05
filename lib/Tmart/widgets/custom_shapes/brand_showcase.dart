import 'package:flashchat/Tmart/widgets/custom_shapes/brand_card.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/rounded_container.dart';

class TBrandShowcase extends StatelessWidget {
  final List<String> images;
  final String brandName;
  final String brandLogo;

  const TBrandShowcase({
    super.key,
    required this.images,
    required this.brandName,
    required this.brandLogo,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      borderColor: Colors.black45,
      margin:8,
      backgroundColor: Colors.white,
      child:Column(
        children: [
          TBrandCard(
            showBorder: false,
            brandName: brandName,
            brandLogo: brandLogo,
          ),
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
        radius: 0,
        borderColor: Colors.white,
        height: 80,
        margin:10,
        child:Image.network(image, fit: BoxFit.contain),
      ),
    );
  }
}
