import 'package:flutter/material.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    this.enableBorderColor=Colors.white,
    this.focusBorderColor=Colors.white,
  });
  final Color enableBorderColor;
  final Color focusBorderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(vertical: 8.0, horizontal:17.0) ,
      child: TextField(
        decoration: InputDecoration(
          filled: true, // Enable background color
          fillColor: Colors.white, // Change background color inside border
          prefixIcon:const Icon(Icons.search,size:30,),
          hintText: 'Search to Store',
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color:enableBorderColor, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusBorderColor, width: 2.0),
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          ),
        ),
      ),
    );
  }
}

