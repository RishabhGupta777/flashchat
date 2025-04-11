import 'package:flutter/material.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/circular_icon.dart';


class TProductQuantityWithAddRemoveButton extends StatelessWidget {
  const TProductQuantityWithAddRemoveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TCircularIcon(icon:Icons.remove,backgroundColor: Colors.grey,height:25,width:25,size:10),
        SizedBox(width:6),
        Text('2',style: Theme.of(context).textTheme.titleSmall,),
        SizedBox(width:6),
        TCircularIcon(icon:Icons.add,backgroundColor: Colors.grey,height: 25,width: 25,size:10),

      ],
    );
  }
}
