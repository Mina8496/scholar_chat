import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constants.dart';
import 'package:scholar_chat/core/widgets/custom_text_field.dart';
import 'package:scholar_chat/feature/chat_page/widget/chat_bubule.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(kLogo, height: 50),
            Text('Scholar Chat', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => ChatBubule(),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.all(16.0),
            child: CustomTextField(
              hintText: 'Send Message',
            
              suffixIcon: Icon(Icons.send, color: kPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
