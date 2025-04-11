import 'package:flutter/material.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/product_price_text.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/product_quantity_with_add_remove_button.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/cart_item.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });
  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 2,
      separatorBuilder: (_, __) =>
      const SizedBox(height:8),
      itemBuilder: (_, index) => Column(
        children: [
          TCartItem(),
          if(showAddRemoveButtons)
          Row(
            children: [
              SizedBox(width: 65,),
              TProductQuantityWithAddRemoveButton(),
              SizedBox(width: 120,),
              TProductPriceText(price: '256'),
            ],
          ),
          SizedBox(height:1),
        ],
      ),
    );
  }
}

