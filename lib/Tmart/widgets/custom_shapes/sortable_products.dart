import 'package:flashchat/Tmart/widgets/custom_shapes/rounded_container.dart';
import 'package:flashchat/Tmart/widgets/product_card/grid_layout.dart';
import 'package:flashchat/Tmart/widgets/product_card/product_card_vertical.dart';
import 'package:flutter/material.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Dropdown
        TRoundedContainer(
          height: 50,
          margin:9,
          padding: 5,
          radius: 12,
          showBorder: true,
          borderColor: Colors.black26,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:12.0),
            child: DropdownButtonFormField(
              decoration:  InputDecoration(
                hintText:'Select  Categories',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: (value) {},
              items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity']
                  .map((option) => DropdownMenuItem(
                value: option,
                child: Text(option),
              ))
                  .toList(),
            ),
          ),
        ),

        /// Spacing
        const SizedBox(height:20),

        /// Products
        TGridLayout(
          itemCount: 8,
          itemBuilder: (_, index) => const TProductCardVertical(),
        ),
      ],
    );
  }
}
