import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/FlashChat/screens/chat_screen.dart';
import 'package:flashchat/Tmart/colors.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/button.dart';
import 'package:flutter/material.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  String name = '';
  String phone = '';
  String state = '';
  String city = '';
  String houseName = '';
  String pinCode = '';
  String area = '';

  Future<void>saveAddressToFirebase()async{
    final uid = FirebaseAuth.instance.currentUser?.email;
     try{
      await FirebaseFirestore.instance.collection('addresses').doc(uid).collection('userAddresses').add({
        'name': name,
        'phone': phone,
        'state': state,
        'city': city,
        'houseName': houseName,
        'pinCode': pinCode,
        'area': area,
        'timestamp': FieldValue.serverTimestamp(),
        'isSelected': false,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Address saved successfully')),
      );
      Navigator.pop(context);
     }catch(e){
       print('Error saving address: $e');
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Failed to save address')),
       );
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text('Add new Address')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height:10),
              TextInputBox(labelText: 'Name',icon:Icon(Icons.person_outline_sharp),onChanged: (val) => name = val),
              const SizedBox(height: 10),
              TextInputBox(labelText:  'Phone Number',icon: Icon(Icons.phone_android_outlined),onChanged: (val) => phone = val),
              const SizedBox(height:10),
              Row(
                children: [
                  Expanded(
                    child:TextInputBox(labelText: 'State', icon: Icon(Icons.map),onChanged: (val) => state = val)
                  ),
                  const SizedBox(width:10),
                  Expanded(
                    child:TextInputBox(labelText: 'City', icon:Icon(Icons.location_city_outlined),onChanged: (val) => city = val)
                  ),
                ],
              ),
              const SizedBox(height:10),
              Row(
                children: [
                  Expanded(
                    child: TextInputBox(labelText: 'House Name', icon: Icon(Icons.home_work_outlined),onChanged: (val) => houseName = val)
                  ),
                  const SizedBox(width:10),
                  Expanded(
                      child:TextInputBox(labelText: 'Pin Code', icon:Icon(Icons.pin_drop_outlined),onChanged: (val) => pinCode = val)
                  ),
                ],
              ),
              const SizedBox(height:10),
              TextInputBox(labelText: 'Area,Colony', icon:Icon(Icons.add_road),onChanged: (val) => area = val),
            ],
          ),
        ),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(8.0),
        child: TButton(
          onTap: saveAddressToFirebase,
          radius: 16,text:'save',height: 53,backgroundColor:TColors.primary,),
      ),
    );
  }
}

class TextInputBox extends StatelessWidget {
  const TextInputBox({
    super.key,
    required this.labelText,
    required this.icon,
    required this.onChanged,
  });
  final String labelText;
  final Widget icon;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: icon,
        labelText:labelText ,
        labelStyle: TextStyle(color:TColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color:TColors.primary, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
    );
  }
}
