import 'package:flashchat/Tmart/colors.dart';
import 'package:flashchat/Tmart/screens/user_address_screen.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/add_new_address_screen.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/singleaddress.dart';
import 'package:flutter/material.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Addresses', style: Theme.of(context).textTheme.headlineSmall),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewAddressScreen(),));
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              TSingleAddress(selectedAddress: false),
              TSingleAddress(selectedAddress: true),
            ],
          ),
        ),
      ),
    );
  }
}

