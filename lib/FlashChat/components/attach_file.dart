import 'package:flutter/material.dart';

class AttachFile extends StatefulWidget {
  const AttachFile({super.key});

  @override
  State<AttachFile> createState() => _AttachFileState();
}

class _AttachFileState extends State<AttachFile> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Padding(
          padding: const EdgeInsets.only(top:26),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AttachIcons(
                onPressed: (){},
                icon: const Icon(Icons.photo,color:Colors.blue),
                iconName:const Text('Galery'),
              ),
              AttachIcons(
                onPressed: (){},
                icon: const Icon(Icons.camera_alt,color:Colors.red),
                iconName:const Text('Camera'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AttachIcons extends StatelessWidget {
  const AttachIcons({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.iconName
  });
  final VoidCallback onPressed;
  final Widget icon;
  final Text iconName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              border: Border.all( // Add this border property
                color: Colors.black54, // Border color
                width: 1.0, // Border width
              ),
              color: Colors.white70,
              borderRadius:BorderRadius.circular(10.0) ,
            ),
            child: IconButton(onPressed:onPressed, icon:icon),),
        iconName
      ],
    );
  }
}
