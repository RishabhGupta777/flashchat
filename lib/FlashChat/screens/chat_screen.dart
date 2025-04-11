import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashchat/FlashChat/components/attach_file.dart';
import 'package:flashchat/FlashChat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.Receiver});
  final String Receiver;

  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textEditingController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? messageText;
  // Added variables to track selected message
  String? selectedMessageId;
  String? selectedMessageText;
  bool ? IsMe;
  bool messageIsSelected = false;
  String? userProfileUrl;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _fetchUserInfo();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
        print(loggedInUser?.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void _fetchUserInfo() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('UsersInfo').doc(widget.Receiver).get();
    if (userDoc.exists) {
      setState(() {
        userProfileUrl = userDoc.get('profilePic');
      });
    }
  }

  void sendMessage() {

    if (selectedMessageId != null) {
      _firestore.collection('messages').doc(selectedMessageId).update({
        'text': messageText,
        // 'timestamp': FieldValue.serverTimestamp(), // Update timestamp
        'isRead': false, //  Added read status
      });
      setState(() {
        selectedMessageId = null;
        selectedMessageText = null;
      });

    } else {
      _firestore.collection('messages').add({
        'text': messageText,
        'sender': loggedInUser?.email,
        'receiver': widget.Receiver, // Added receiver field
        'timestamp': FieldValue.serverTimestamp(), // For sorting messages
        'isRead': false, //  Added read status
      });
    }

    textEditingController.clear();
    setState(() {
      messageText = null; //taki dubara mssg kare to pahle wala mssg messageText me store na rahe
      // nahi to send icon dikata rahega
    });
  }

  // Function to delete selected message
  void deleteMessage() {
    if (selectedMessageId != null) {
      _firestore.collection('messages').doc(selectedMessageId).delete();
      setState(() {
        selectedMessageId = null;
        selectedMessageText = null;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          // Show Edit and Delete icons only when a message is selected
          if (selectedMessageId != null) ...[
            if(IsMe==true)
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.black54),
              onPressed: (){
                if (selectedMessageId != null) {
                  textEditingController.text = selectedMessageText!; // Prevent null value
                }
              }// Calls edit function
            ),

            IconButton(
              icon: const Icon(Icons.copy, color: Colors.black54),
              onPressed: () {
                Clipboard.setData(ClipboardData(text:selectedMessageText!)); // Copy text
                //Clipboard.setData() → This function is called to store data in the clipboard.
                // ClipboardData(text: text) → Creates a clipboard data object containing the text that will be copied.
                setState(() {
                  selectedMessageId = null;
                  selectedMessageText = null;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Message copied!",style: TextStyle(color: Colors.black),),
                    backgroundColor: Colors.white,),
                );
                //ScaffoldMessenger.of(context) ->Retrieves the nearest ScaffoldMessenger associated with the given context.
                // ScaffoldMessenger manages SnackBar messages.
                //.showSnackBar(SnackBar(...))-->Displays a Snackbar.The SnackBar widget is used to create a temporary message that appears at the bottom of the screen.
                //SnackBar(content: Text("Message copied!"))->Creates a Snackbar with "Message copied!" as its text.
              },
            ),

            if(IsMe==true)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.black54),
              onPressed: () => deleteMessage(), // Calls delete function
            ),
          ],
        ],
        leading:selectedMessageId != null ?  null :
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: userProfileUrl != null
              ? CircleAvatar(
            radius:18,
            backgroundImage: CachedNetworkImageProvider(userProfileUrl!),
          )
              : const Icon(Icons.person),
        ),
        title:selectedMessageId != null ?  const Text(" ") : Text(widget.Receiver),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0), // Height of the line
          child: Container(
            color: Colors.black12, // Line color
            height: 1.0, // Thickness of the line
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/chatBackgrounds.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessageStream(
                receiver: widget.Receiver,
                messageIsSelected: messageIsSelected,
                onMessageTap: (id, text,isMe) {
                  setState(() {
                    if (selectedMessageId == id) {   //This makes it so that tapping a message once selects it, and tapping it again deselects it.
                      selectedMessageId = null;
                      selectedMessageText = null;
                      messageIsSelected = false;
                    } else {
                      selectedMessageId = id;
                      selectedMessageText = text;
                      IsMe = isMe;
                      messageIsSelected = true;
                    }
                  });

                },
              ),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        onChanged: (value) {
                          setState(() {
                            messageText = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled:true,
                          fillColor: Colors.white,
                          //final use here-->const means the entire object must be immutable at compile time. , IconButton has onPressed, which is a function (not a constant value). , Since the onPressed callback is mutable, Dart does not allow const here.
                          suffixIcon: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => const AttachFile());
                            },
                            icon: const Icon(Icons.attach_file),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          hintText: 'Message',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (messageText != null && messageText!.trim().isNotEmpty)
                      Container(
                        color: Colors.white,
                        child: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.blue,
                          ),
                          onPressed: sendMessage,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  final String receiver;
  final Function(String id, String text,bool isMe) onMessageTap;
  final bool messageIsSelected;
  const MessageStream({super.key, required this.receiver, required this.onMessageTap,required this.messageIsSelected});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .orderBy('timestamp',
              descending: true) // Sort by latest message first
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final messages = snapshot.data!.docs;
        List<MessageBubble> messageBubbles = [];

        for (var message in messages) {
          final messageText = message['text'];
          final messageSender = message['sender'];
          final messageReceiver = message['receiver'];
          final messageTime=message['timestamp'] as Timestamp?; // Get timestamp
          final messageId = message.id; //for delete mssg
          final isRead = message['isRead'] ?? false; //  Check read status
          final currentUser = loggedInUser?.email;

          if ((messageSender == currentUser && messageReceiver == receiver) ||
              (messageSender == receiver && messageReceiver == currentUser)) {
            if (messageReceiver == currentUser && !isRead) {
              //aman ne mujhe mssg kiya jab messagereceiever(mai tha) and now currentuser(mai login krke chala raha hu) then
              // messagereceiever= currentuser then maine mssg padh liya
              //!isRead means "isRead is false"-->The message has not been read yet .

              //  Mark message as read when receiver views it
              _firestore
                  .collection('messages')
                  .doc(messageId)
                  .update({'isRead': true});
            }

            final messageBubble = MessageBubble(
              text: messageText,
              sender: messageSender,
              isMe: currentUser == messageSender,
              timestamp: messageTime,
              messageId: messageId, //for delete mssg
              isRead: isRead, //  Pass read status
              onMessageTap: onMessageTap,
              messageIsSelected: messageIsSelected,
            );
            messageBubbles.add(messageBubble);
          }
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, 
    required this.text,
    required this.sender,
    required this.isMe,
    required this.timestamp,
    required this.messageId,
    required this.isRead,
    required this.onMessageTap,
    required this.messageIsSelected
  });

  final String text;
  final String sender;
  final bool isMe;
  final Timestamp? timestamp; // Timestamp for message time
  final String messageId; //for delete mssg
  final bool isRead; //for mssg read or not
  final Function(String id, String text,bool isMe) onMessageTap;
  final bool messageIsSelected;

  @override
  Widget build(BuildContext context) {
    String timeString = '';


    if (timestamp != null) {
      DateTime messageTime =
          timestamp!.toDate(); // Convert Firestore timestamp to DateTime
      //In Firestore, timestamps are stored as Timestamp objects, not as standard DateTime objects.
      // timestamp!.toDate() converts the Timestamp into a DateTime object.
      // The ! operator means that timestamp is non-null (to avoid null errors).

      timeString =
          DateFormat.jm().format(messageTime); // Format time (e.g., 10:30 AM)
      // The   intl   package provides DateFormat.jm(), which formats time in a user-friendly way.
      //.jm() stands for "Hour and Minute in AM/PM format".
      // .format(messageTime) converts the DateTime into a readable string.
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onLongPress: () {
              onMessageTap(messageId, text,isMe);
            },
            onTap: () {
              if(messageIsSelected==true) {
                onMessageTap(messageId, text,
                    isMe); // This will deselect when tapped again
              }
            },
            child: Material(
              borderRadius: isMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0))
                  : const BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
              elevation: 5.0,
              color: isMe ? Colors.lightGreen : Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5), // Adjusted padding
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.end, // Align time to the right
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                          color: isMe ? Colors.white : Colors.black,
                          fontSize: 15.0),
                    ),
                    // SizedBox(height: 1), // Space between message and time
                    Row(
                      mainAxisSize:MainAxisSize.min, //nahi to pura screen cover karega row
                      children: [
                        Text(
                          timeString //+ (isMe ? (isRead ? ' ✓✓' : ' ✓') : '')  <-- also can be done
                          ,
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black45), // Smaller text for time
                        ),
                        if (isMe) const SizedBox(width: 5),
                        if (isMe)
                          isRead
                              ? const Icon(Icons.done_all,
                                  size: 16, color: Colors.blue)
                              : const Icon(Icons.done, size: 16), // Checkmark icons
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
