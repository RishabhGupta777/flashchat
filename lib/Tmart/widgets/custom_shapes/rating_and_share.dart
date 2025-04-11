import 'package:flutter/material.dart';

class TRatingAndShare extends StatelessWidget {
  const TRatingAndShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.star_border_purple500,color: Colors.amber,size: 24,),
            SizedBox(width: 4,),
            Text.rich(
                TextSpan(
                    children: [
                      TextSpan(text: '5',style: TextStyle(fontWeight: FontWeight.w800)),
                      TextSpan(text: '(199)'),
                    ]
                )
            ),
          ],
        ),
        IconButton(onPressed: (){}, icon: Icon(Icons.share,size:24))
      ],
    );
  }
}

