import 'package:flashchat/Tmart/widgets/custom_shapes/brand_card.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/sortable_products.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nike'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TBrandCard(showBorder: true),
            TSortableProducts()
          ],
        ),
      ),
    );
  }
}
