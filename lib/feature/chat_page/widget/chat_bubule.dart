import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constants.dart';

class ChatBubule extends StatelessWidget {
  const ChatBubule({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 150,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 16),
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          topLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Text("i am new User", style: TextStyle(color: Colors.white)),
    );
  }
}