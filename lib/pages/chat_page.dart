import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chat_app/components/chat_bubble.dart';
import 'package:minimal_chat_app/components/my_textfield.dart';
import 'package:minimal_chat_app/services/auth/auth_service.dart';
import 'package:minimal_chat_app/services/chat/chat_services.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  //text controller
  final TextEditingController _messageController = TextEditingController();

  //chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //send message
  void sendMessage() async {
    //if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      //send the message
      await _chatService.sendMessage(receiverID, _messageController.text);

      //clear text controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(receiverEmail),
          backgroundColor: Colors.amber.shade100,
          foregroundColor: const Color.fromARGB(255, 51, 51, 51),
          elevation: 0,
          actions: [
            // Add actions to the AppBar, like the three dots icon
            Padding(
              padding: const EdgeInsets.only(
                  right: 16.0), // Adjust padding as needed
              child: Image.asset(
                'assets/icons/chat.png',
                width: 30, // Adjust size to fit in the AppBar
                height: 30,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            //display all messages
            Expanded(
              child: _buildMessageList(),
            ),

            //user input
            _buildUserInput(),
          ],
        ));
  }

  //build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        //errors

        if (snapshot.hasError) {
          return const Text("Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }

        //return list view
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    //align message to the right if sender is the current user, otherwise align to the left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: data["message"],
            isCurrentUser: isCurrentUser,
          )
        ],
      ),
    );
  }

  //build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          //textfield should take up most of the space
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: "Quack a message",
              obsecureText: false,
            ),
          ),

          //Send button
          Container(
            decoration: const BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(115, 160, 160, 160),
                  offset: const Offset(5.0, 5.0),
                  blurRadius: 5.0,
                ),
              ],
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.arrow_upward),
            ),
          ),
        ],
      ),
    );
  }
}
