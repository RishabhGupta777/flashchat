import 'package:flashchat/Tmart/widgets/custom_shapes/button.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/cart_items.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/rounded_container.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/section_heading.dart';
import 'package:flutter/material.dart';

class Checkoutscreen extends StatelessWidget {
  const Checkoutscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Review',style:Theme.of(context).textTheme.headlineSmall),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
           children: [
             TCartItems(showAddRemoveButtons: false,),
             SizedBox(height: 14,),
             TCouponCode(),
             SizedBox(height: 16,),
             TRoundedContainer(
               showBorder: true,
               borderColor: Colors.black12,
               padding: 8,
               child: Column(
                 children: [
                   TAmountAmountSection(),
                   const SizedBox(height:14),
                   Divider(),
                   TBillingPaymentSection(),
                   TBillingAddressSection(),
                 ],
               ),
             )
           ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: TButton(
          height:50,
          radius: 16,
          onTap: (){},
          text: 'Checkout ₹256.0',
        ),
      ),
    );
  }
}

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () {},
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rishabh Gupta',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height:8),
              Row(
                children: [
                  const Icon(Icons.phone, color: Colors.grey, size: 16),
                  const SizedBox(width:12),
                  Text(
                    '+91-917809525',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height:8),
              Row(
                children: [
                  const Icon(Icons.location_history, color: Colors.grey, size: 16),
                  const SizedBox(width:12),
                  Expanded(
                    child: Text(
                      'South Liana, Maine 87695, USA',
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
     children: [
       TSectionHeading(title: 'Payment Method',buttonTitle:'Change' , onPressed: (){},),
       Row(
         children: [
           TRoundedContainer(
             width: 60,
             height: 35,
             child: Image.asset('assets/images/paytm.png',fit:BoxFit.contain,),
           ),
           SizedBox(width: 6,),
           Text('Paytm',style: Theme.of(context).textTheme.bodyLarge,)
         ],
       ),

     ],
    );
  }
}

class TAmountAmountSection extends StatelessWidget {
  const TAmountAmountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// SubTotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
            Text('₹256.0', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height:8),

        /// Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('₹6.0', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: 8),

        /// Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('₹6.0', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height:6),

        /// Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
            Text('₹6.0', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}

class TCouponCode extends StatelessWidget {
  const TCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      borderColor: Colors.black12,
      height: 60,
      width: double.infinity,
      radius:12,
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Have a promo code? Enter here',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            TButton(height:44,onTap: (){},width:80,backgroundColor: Colors.grey,text: 'Apply', ),
          ],
        ),
      ),
      );
  }
}
