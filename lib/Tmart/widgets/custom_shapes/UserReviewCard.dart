import 'package:flashchat/Tmart/widgets/custom_shapes/rating_bar_indicator.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/rounded_container.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/text_read_more.dart';
import 'package:flutter/material.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image.asset("assets/images/profile.png",
                    width: 50, height: 50, fit: BoxFit.cover ),
                ),
               SizedBox(width:8),
                Text('Elon Musk',style: Theme.of(context).textTheme.titleLarge,)
              ],
            ),
            IconButton(onPressed: (){},icon:const Icon(Icons.more_vert)),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            TRatingBarIndicator(rating: 4),
            SizedBox(width:6),
            Text('01 NOV 2023',style:Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        SizedBox(height: 10,),
        TextReadMore(text: 'The User interface of the top is quite intutive.I was able to naviagate and make purchase seamlessly. Great job!  '),

        ///Company Review
        TRoundedContainer(
          margin:4,
          padding:10,
          radius: 12,
          backgroundColor: Colors.black12,
          child:Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("T's Store",style: Theme.of(context).textTheme.titleMedium,),
                  Text("02 Nov,2023",style: Theme.of(context).textTheme.bodyMedium,),
                ],
              ),
              SizedBox(height: 10,),
              TextReadMore(text: 'The User interface of the top is quite intutive.I was able to naviagate and make purchase seamlessly. Great job!  '),

            ],
          )
        ),

        SizedBox(height: 10,),
      ],
    );
  }
}
