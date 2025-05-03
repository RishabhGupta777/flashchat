import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

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
        IconButton(onPressed: (){
          final params = ShareParams(
            text:'Check out this product on Tmart!\n\nName: Amazing Product\nPrice: \$99\nLink: https://example.com/product/123',
            subject: 'Awesome product on Tmart',
          );
         SharePlus.instance.share(params);
        }, icon: Icon(Icons.share,size:24))
      ],
    );
  }
}

