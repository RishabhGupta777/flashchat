import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/Tmart/colors.dart';
import 'package:flashchat/Tmart/screens/user_address_screen.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/add_new_address_screen.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/singleaddress.dart';
import 'package:flutter/material.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.email;
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
        child:SingleChildScrollView(
          child:StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('addresses')
                .doc(uid)
                .collection('userAddresses')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No addresses found.'));
              }

              final addressDocs = snapshot.data!.docs;

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: addressDocs.length,
                itemBuilder: (context, index) {
                  final doc = addressDocs[index];
                  final data = doc.data() as Map<String, dynamic>;
                  final isSelected = data['isSelected'] ?? false;

                  return GestureDetector(
                    onTap: () async {
                      // Unselect all addresses
                      for (final addr in addressDocs) {
                        await addr.reference.update({'isSelected': false});
                      }

                      // Select the tapped one
                      await doc.reference.update({'isSelected': true});
                    },
                    child: TSingleAddress(
                      selectedAddress:isSelected, // mark first as selected
                      name: data['name'] ?? '',
                      phone: data['phone'] ?? '',
                      fullAddress:
                      '${data['houseName']}, ${data['area']}, ${data['city']}, ${data['state']}, ${data['pinCode']}',
                    ),
                  );
                },
              );
            },
          ),

        ),
      ),
    );
  }
}

