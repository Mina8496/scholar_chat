import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constants.dart';
import 'package:scholar_chat/core/widgets/custom_text_field.dart';
import 'package:scholar_chat/feature/chat_page/model/message.dart';
import 'package:scholar_chat/feature/chat_page/widget/chat_bubule.dart';

class ChatPage extends StatelessWidget {
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollection,
  );

  ChatPage({super.key});
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: messages.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messageList = snapshot.data!.docs
              .map((document) => Message.fromJson(
                    document.data() as Map<String, dynamic>,
                  ))
              .toList();
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
                    itemCount: messageList.length,
                    itemBuilder: (context, index) =>
                        ChatBubule(message: messageList[index]),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.all(16.0),
                  child: CustomTextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({kMessage: data});
                      controller.clear();
                    },

                    hintStyle: TextStyle(color: kPrimaryColor),
                    hintText: 'Send Message',
                    borderSide: BorderSide(color: kPrimaryColor),
                    suffixIcon: Icon(Icons.send, color: kPrimaryColor),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              children: [CircularProgressIndicator(), Text('Loading ...')],
            ),
          );
        }
      },
    );
  }
}
