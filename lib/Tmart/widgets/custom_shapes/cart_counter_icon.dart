
import 'package:flutter/material.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    this.iconColor=Colors.white,
    this.onPressed,
  });
  final Color iconColor;
  final VoidCallback ? onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(children:[
      IconButton(
        icon: Icon(Icons.shopping_bag_outlined, color: iconColor),
        onPressed: onPressed,
      ),
      const Positioned(
          right:10,
          top:10,
          child:CircleAvatar(
            backgroundColor: Colors.black,
            radius: 5,
            child: Text('2',style: TextStyle(fontSize:5.5,color: Colors.white,),),
          ) )
    ]);
  }
}
