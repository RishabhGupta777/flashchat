import 'package:flashchat/Tmart/widgets/custom_shapes/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/Tmart/colors.dart';

class TButton extends StatelessWidget {
  final double ? width;
  final double ? height;
  final Color backgroundColor;
  final String ? text;
  final VoidCallback onTap;
  final double radius;

  const TButton({
    super.key,
    this.width ,
    this.height ,
    this.backgroundColor = TColors.primary,
    required this.text ,
    required this.onTap,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: TRoundedContainer(
        backgroundColor: backgroundColor,
        width: width,
        height: height,
        radius: radius,
        child: Center(
          child: Text(
            text!,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
