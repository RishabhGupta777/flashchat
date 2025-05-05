import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashchat/FlashChat/components/webview_screen.dart';
import 'package:flashchat/FlashChat/screens/my_Profile.dart';
import 'package:flashchat/FlashChat/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/Tmart/screens/cart_screen.dart';
import 'package:flashchat/Tmart/screens/orderlistsItems.dart';
import 'package:flashchat/Tmart/screens/user_address_screen.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final _auth = FirebaseAuth.instance; //_auth is object and FirebaseAuth isa class
  String name = "Loading... ";
  String? userProfileUrl;
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUserInfo();
  }

  void _fetchUserInfo() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('UsersInfo').doc(_auth.currentUser!.email).get();
    if (userDoc.exists) {
      setState(() {
        name = userDoc.get('name') ?? "No Name";
        userProfileUrl = userDoc.get('profilePic');
        isLoading = false; // Stop loading once data is fetched
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String ? loggedInUser = _auth.currentUser!.email; // Get current user

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text(name,style: TextStyle(color: Colors.black),),
              accountEmail:Text('$loggedInUser',style: TextStyle(color: Colors.black),),
              currentAccountPicture: CircleAvatar(
                  radius: 77, // Adjust the size
                backgroundColor: Colors.white,
                child: userProfileUrl != null
                    ? ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: userProfileUrl!,
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                )
                    : const Icon(Icons.person, size: 40, color: Colors.white),
              ),

            decoration: const BoxDecoration(
              color: Colors.white,   //yha lightBlueAccent color tha
            ),
          ),
          ListTile(
          onTap: (){ Navigator.push(context, MaterialPageRoute(
    builder: (context) =>const MyProfile(),),
    );},
            leading: const Icon(Icons.person_outline_sharp),
            title: const Text('My Profile'),
          ),
          ListTile(
            onTap: (){ Navigator.push(context, MaterialPageRoute(
              builder: (context) => const WebViewScreen(url: 'https://www.dcrustm.ac.in/'),),
    );
    },
            leading: const Icon(Icons.local_phone_outlined),
            title: const Text('Contacts'),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserAddressScreen(),));
            },
            leading: Icon(Icons.home_work_outlined),
            title: Text('My Address'),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen(),));
            },
            leading: Icon(Icons.shopping_cart_outlined),
            title: Text('My Cart'),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TOrderListItems(),));
            },
            leading: Icon(Icons.local_shipping_outlined,),
            title: Text('My Orders'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {
    _auth.signOut();
    Navigator.pushReplacementNamed(context, WelcomeScreen.id);
    //Implement logout functionality
    }),

        ],
      ),
    );
  }
}
