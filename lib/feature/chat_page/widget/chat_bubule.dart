import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constants.dart';

class ChatBubule extends StatelessWidget {
  const ChatBubule({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text("i am new User", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
