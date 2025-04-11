import 'package:flashchat/Tmart/widgets/custom_shapes/sortable_products.dart';
import 'package:flutter/material.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({super.key});

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Popular Products'),
      ),
      body: SingleChildScrollView(
        child: TSortableProducts(),
      ),
    );
  }
}

