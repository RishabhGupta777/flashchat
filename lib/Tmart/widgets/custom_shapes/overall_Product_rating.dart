import 'package:flashchat/Tmart/widgets/custom_shapes/rating_progress_indicator.dart';
import 'package:flutter/material.dart';

class TOverallProductRating extends StatelessWidget {
  const TOverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex:3 ,child: Text('4.8',style:Theme.of(context).textTheme.displayLarge)),
        Expanded(
          flex:7,
          child: Column(
            children: [
              TRatingProgressIndicator(text: '5',value: 0.9,),
              TRatingProgressIndicator(text: '4',value: 0.7,),
              TRatingProgressIndicator(text: '3',value: 0.5,),
              TRatingProgressIndicator(text: '2',value: 0.4,),
              TRatingProgressIndicator(text: '1',value: 0.1,),
            ],
          ),
        )
      ],
    );
  }
}

