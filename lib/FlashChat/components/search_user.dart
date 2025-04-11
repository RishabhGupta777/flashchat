import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashchat/FlashChat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
final textEditingController = TextEditingController();

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final textEditingController = TextEditingController();
  final _auth = FirebaseAuth.instance; //_auth is object and FirebaseAuth isa class
  String? messageText;
  String name='' ;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          //Use setState() when updating loggedInUser to ensure UI updates.
          loggedInUser = user;
        });
        print(loggedInUser?.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const <Widget>[
        ],
        title: TextField(
          autofocus: true,
          controller: textEditingController,
          decoration: const InputDecoration(
            // filled: true, // Enable background color
            // fillColor: Colors.black12, // Change background color inside border
            prefixIcon: Icon(Icons.search,),
            hintText: 'Search',
            contentPadding: EdgeInsets.symmetric(horizontal:13.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
          onChanged: (value){
            setState(() {
              name= value.toLowerCase(); // Convert to lowercase for case-insensitive search;
              //value to search User
            });
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            MessageStream(searchQuery: name), // Pass searchQuery to MessageStream
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  final String searchQuery;
  const MessageStream({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('UserId').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final registerIds = (snapshot.data!).docs;
          List<UserBubble> userBubbles =
          []; //pahle Text widget ka list tha but ab MessageBubble naam ke stateless widget ka list
          for (var registerId in registerIds) {
            final registerEmail = registerId['register'];

            final currentUser = loggedInUser?.email;

            // Filter users based on search input
            if (searchQuery.isNotEmpty && // Ensure searchQuery is not empty-->Now, the users will only appear when the search bar has input.
                registerEmail != currentUser &&
                registerEmail.toLowerCase().contains(searchQuery)) {
              userBubbles.add(UserBubble(registeredEmail: registerEmail));
            }
          }
          return Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: userBubbles,
            ),
          );
        });
  }
}

class UserBubble extends StatefulWidget {
  //Now messageBubble is A Widget

  const UserBubble({super.key, required this.registeredEmail});
  final String registeredEmail;

  @override
  State<UserBubble> createState() => _UserBubbleState();
}

class _UserBubbleState extends State<UserBubble> {
  String? userProfileUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  void _fetchUserInfo() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('UsersInfo').doc(widget.registeredEmail).get();
    if (userDoc.exists) {
      setState(() {
        userProfileUrl = userDoc.get('profilePic');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // har build ke par padding laga diya h
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    Receiver:widget.registeredEmail,
                  ),
                ),
              );
              textEditingController.clear();
            },

            leading:  userProfileUrl != null
                ? CircleAvatar(
              radius:25,
              backgroundImage: CachedNetworkImageProvider(userProfileUrl!),
            )
                : const Icon(Icons.person),

            title:  Text(
              widget.registeredEmail,
              style: const TextStyle(color: Colors.black54, fontSize: 15.0),
            ),

          ),
        ],
      ),
    );
  }
}
