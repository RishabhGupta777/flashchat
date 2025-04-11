import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashchat/FlashChat/components/nar_bar.dart';
import 'package:flashchat/FlashChat/components/search_user.dart';
import 'package:flashchat/FlashChat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
// User? loggedInUser; //loggedInUser is declared as late Firebase, but Firebase
// is not the correct type. It should be User? because FirebaseAuth.currentUser returns a User? object.

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      drawer: const NavBar(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchUser()),
            );
          }),
        ],
        title: const Text('⚡️ Chat'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0), // Height of the line
          child: Container(
            color: Colors.black12, // Line color
            height: 1.0, // Thickness of the line
          ),
        ),
      ),
      body: const SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

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
          List<UserBubble> userBubbles=[]; //pahle Text widget ka list tha but ab MessageBubble naam ke stateless widget ka list
          for (var registerId in registerIds) {
            final registerEmail = registerId['register'];
            final currentUser = loggedInUser?.email;

            if (registerEmail != currentUser){    //taki user ki khud ki id userlist me na jae
              final userBubble = UserBubble(
                registeredEmail: registerEmail,
              );

            userBubbles.add(userBubble);
          }
          }

          return Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                        Receiver: widget.registeredEmail,
                    ),
                  ),
                );
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
