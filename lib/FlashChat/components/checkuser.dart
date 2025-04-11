import 'package:flashchat/FlashChat/components/navigation_menu.dart';
import 'package:flashchat/FlashChat/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckUser extends StatefulWidget {
  static const String id = 'checkuser';

  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  final _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return checkUser();
  }

  checkUser(){
    final user= _auth.currentUser;
    if(user!=null){
      return const NavigationMenu();
    }else{
      return const WelcomeScreen();
    }
  }

}




// import 'package:challenge1/FlashChat/constants.dart';
// import 'package:challenge1/FlashChat/screens/welcome_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
//
// final _firestore = FirebaseFirestore.instance;
// User? loggedInUser;   //loggedInUser is declared as late Firebase, but Firebase
// // is not the correct type. It should be User? because FirebaseAuth.currentUser returns a User? object.
//
// class ChatScreen extends StatefulWidget {
//
//   ChatScreen({required this.Receiver});
//   final String Receiver;
//
//   static const String id = 'chat_screen';
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final textEditingController= TextEditingController();
//   final  _auth=FirebaseAuth.instance;   //_auth is object and FirebaseAuth isa class
//   String ? messageText;
//
//   @override
//   void initState() {
//     super.initState();
//     getCurrentUser();
//   }
//
//   void getCurrentUser(){
//     try {
//       final user = _auth.currentUser;
//       if (user != null) {
//         setState(() {    //Use setState() when updating loggedInUser to ensure UI updates.
//           loggedInUser = user;
//         });
//         print(loggedInUser?.email);
//       }
//     }catch(e){
//       print(e);
//     }
//   }
//
//   // void messagesStream()async{
//   //   await for(var snapshot in _firestore.collection('messages').snapshots() ){
//   //     for (var message in snapshot.docs){
//   //       print(message.data());
//   //     }
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: null,
//         actions: <Widget>[
//           IconButton(
//               icon: Icon(Icons.logout),
//               onPressed: () {
//                 _auth.signOut();
//                 Navigator.pushReplacementNamed(context,WelcomeScreen.id);
//                 //Implement logout functionality
//               }),
//         ],
//         title: Text(widget.Receiver),
//         backgroundColor: Colors.lightBlueAccent,
//       ),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//
//           children: <Widget>[
//
//             MessageStream(),
//
//             Container(
//               decoration: kMessageContainerDecoration,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Expanded(
//                     child: TextField(
//                       controller: textEditingController,
//                       onChanged: (value) {
//                         setState(() {
//                           messageText = value;
//                         });
//                       },
//                       decoration: kMessageTextFieldDecoration,
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.send,color: Colors.blue,),
//                     onPressed: () {
//                      _firestore.collection('messages').add({
//                        'text': messageText,
//                        'sender': loggedInUser?.email,   //loggedInUser is a User? Object, Not a String
//                      //When adding data to Firestore, the sender field should store a string (like the user's email), not a User? object
//                      });
//                      textEditingController.clear();
//                     },
//                     // child: Text(
//                     //   'Send',
//                     //   style: kSendButtonTextStyle,
//                     // ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MessageStream extends StatelessWidget {
//   const MessageStream({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream:_firestore.collection('messages').snapshots(),
//         builder: (context,snapshot){
//           if(!snapshot.hasData){
//             return Center(
//               child: CircularProgressIndicator(
//                 backgroundColor: Colors.lightBlueAccent,
//               ),
//             );
//           }
//           final messages = (snapshot.data! as QuerySnapshot).docs.reversed;
//           List<MessageBubble> messageBubbles = [];   //pahle Text widget ka list tha but ab MessageBubble naam ke stateless widget ka list
//           for (var message in messages) {
//             final messageText = message['text'];
//             final messageSender = message['sender'];
//
//             final currentUser = loggedInUser?.email;
//
//
//             final messageBubble =MessageBubble(
//               text: messageText,
//               sender: messageSender,
//               isMe: currentUser==messageSender,);
//
//             messageBubbles.add(messageBubble);
//           }
//           return Expanded(
//             child: ListView(
//               reverse: true,
//               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
//               children: messageBubbles,
//             ),
//           );
//
//         }
//     );
//   }
// }
//
//
// class MessageBubble extends StatelessWidget {     //Now messageBubble is A Widget
//
//   MessageBubble({required this.text,required this.sender,required this.isMe});
//   final String text;
//   final String sender;
//   final bool isMe;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(   // har build ke par padding laga diya h
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: [
//           Text(sender,
//           style: TextStyle(
//             fontSize: 12.0,
//             color: Colors.black54,
//           ),
//           ),
//           Material(
//             borderRadius:isMe? BorderRadius.only(
//               topLeft: Radius.circular(20.0),
//                bottomLeft: Radius.circular(20.0),
//                 bottomRight: Radius.circular(20.0)
//             ) : BorderRadius.only(
//                 topRight: Radius.circular(20.0),
//                 bottomLeft: Radius.circular(20.0),
//                 bottomRight: Radius.circular(20.0)
//             )
//             ,
//             elevation: 5.0,
//             color: isMe ? Colors.lightGreen : Colors.white,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal:10,vertical:5),   //more padding due to material around our text is too close to our text;
//               child: Text(text,
//                 style: TextStyle(
//                     color: isMe ? Colors.white : Colors.black54,
//                     fontSize: 15.0),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );;
//   }
// }

