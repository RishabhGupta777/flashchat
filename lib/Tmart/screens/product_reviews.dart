import 'package:flashchat/Tmart/widgets/custom_shapes/UserReviewCard.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/overall_Product_rating.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/rating_bar_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews & Ratings"),
      ),
      body:SingleChildScrollView(
        child:Padding(
            padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Rating and reviews are verified and are from peaople who use the same type of devise that you use."),
             SizedBox(height: 10,),

              ///overall Product reviews
              TOverallProductRating(),
              TRatingBarIndicator(rating:4.6,),
              Text('12,611',style: Theme.of(context).textTheme.bodySmall,),

            ///User Review List
              SizedBox(height:10),
              UserReviewCard(),
              UserReviewCard(),
            ],
        ),
        ),
      )
    );
  }
}



