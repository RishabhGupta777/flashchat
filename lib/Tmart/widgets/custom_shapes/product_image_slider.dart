import 'package:flashchat/Tmart/colors.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/circular_icon.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/rounded_container.dart';
import 'package:flashchat/Tmart/widgets/product_card/product_card_vertical.dart';


class TProductImageSlider extends StatefulWidget {
  const TProductImageSlider({
    super.key,
   required this.images,
  });
  final List images;

  @override
  State<TProductImageSlider> createState() => _TProductImageSliderState();
}

class _TProductImageSliderState extends State<TProductImageSlider> {
  int selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height:28),
        TRoundedContainer(
          margin: 6,
          borderColor: Colors.white,
          child: Stack(
            children: [
              SizedBox(
                height: 350,
                width: 350,
                child: Image.network(
                  widget.images[selectedImageIndex],
                  fit: BoxFit.cover, // Ensures it fills the rounded shape properly
                ),),
              Positioned(
                top:10,
                  right: 10,
                  child: TCircularIcon(icon: Icons.favorite,color: Colors.red,)),
            ],
          ),
        ),
        SizedBox(
          height: 78,
          child: ListView.separated(
            itemCount: widget.images.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(), // Allows smooth scrolling
            separatorBuilder: (_,__)=>SizedBox(width:6),
            itemBuilder: (_,index)=>GestureDetector(
              onTap: () {
                setState(() {
                  selectedImageIndex = index;
                });
              },
              child: TRoundedContainer(
                margin: 2,
                width:78,
                radius: 0,
                showBorder: true,
                borderColor: selectedImageIndex == index ? Colors.blue : Colors.black26,
                child:Image.network(
                  widget.images[index],
                  fit: BoxFit.cover, // Ensures it fills the rounded shape properly
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
