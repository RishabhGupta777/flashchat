import 'package:flashchat/Tmart/colors.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/section_heading.dart';
import 'package:flutter/material.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text('Add new Address')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TSectionHeading(title: 'Name', showActionButton: false),
              const SizedBox(height:10),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_sharp),
                  labelText: 'Name',
                  border: OutlineInputBorder(), // This enables a visible border
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone_android_outlined),
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(), // This enables a visible border
                ),
              ),
              const SizedBox(height:10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_city),
                        labelText: 'Street',
                        border: OutlineInputBorder(), // This enables a visible border
                      ),
                    ),
                  ),
                  const SizedBox(width:10),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(), // This enables a visible border
                        prefixIcon: Icon(Icons.gamepad),
                        labelText: 'Pin Code',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height:10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(), // This enables a visible border
                        prefixIcon: Icon(Icons.map),
                        labelText: 'State',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(TColors.primary),),
                  onPressed: () {},
                  child: const Text('Save'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
