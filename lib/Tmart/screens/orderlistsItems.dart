import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/Tmart/colors.dart';
import 'package:flashchat/Tmart/screens/product_detail.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/product_title_text.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TOrderListItems extends StatelessWidget {
  const TOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.email;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Order'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orderlist')
            .doc(userId)
            .collection('items')
            .orderBy('orderDate', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No orders found.'));
          }
          final orders = snapshot.data!.docs;

          return ListView.separated(
            shrinkWrap: true,
            itemCount: orders.length,
            separatorBuilder: (_, __) => const SizedBox(height:0),
            itemBuilder: (_, index){
              final order = orders[index].data() as Map<String, dynamic>;
              final name=order['name'];
              final status=order['status'];
              final variation=order['variation'] as Map<String, dynamic>;
              final imageUrl=variation['pic'];
              final orderDate = (order['orderDate'] as Timestamp).toDate();
              final formattedDate = DateFormat('dd MMM yyyy').format(orderDate);
              final variationIndex=order['variationIndex'] ?? 0;
              return GestureDetector(
                onTap: ()async{
                  final productId=order['productId'];
                  final productDoc =await FirebaseFirestore.instance
                      .collection('Products')
                      .doc(productId)
                      .get();
                  if (productDoc.exists) {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(document: productDoc, selectedVariationIndex: variationIndex,
                        ),
                      ),
                    );
                 }
                },
                child: TRoundedContainer(
                margin: 10,
                showBorder: true,
                borderColor: Colors.black12,
                child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TRoundedContainer(
                          height: 100,
                          width: 100,
                          radius: 15,
                          child:Image.network(imageUrl, height: 100, fit: BoxFit.cover,),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0,top:8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width:136,
                              child: TProductTitleText(title:name,isLarge:false,),),
                            Text(status ?? 'Processing',
                              style: Theme.of(context).textTheme.bodyLarge!.apply(
                                  color: TColors.primary, fontWeightDelta: 1),),
                            SizedBox(height: 3,),
                            Row(
                              children: [
                                        const Icon(Icons.calendar_month_outlined),
                                        const SizedBox(width: 8),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Ordered On',
                                              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                                color: Colors.black45,
                                              ),
                                            ),
                                            Text(
                                              formattedDate,
                                              style: Theme.of(context).textTheme.titleMedium,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                          ],
                        ),
                      )
                    ]
                ),
                            ),
              );
            }
          );
        }
      )
    );
  }
}
