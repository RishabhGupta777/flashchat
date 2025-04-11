import 'package:flutter/material.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/chice_chip.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text('Colors', style:Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 2),
        TChoiceChip(
          isCircular: true,
          colors: [Colors.red, Colors.blue, Colors.green], // Pass colors
        ),

        const SizedBox(height:5),
        Text('Size', style:Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 3),
        TChoiceChip(
          isCircular: false,
          texts: ["Small", "Medium", "Large","X-Large","XX-Large"], // Pass text options
        ),
      ],
    );
  }
}

