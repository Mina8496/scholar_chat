import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constants.dart';
import 'package:scholar_chat/core/widgets/custom_text_field.dart';
import 'package:scholar_chat/feature/chat_page/model/message.dart';
import 'package:scholar_chat/feature/chat_page/widget/chat_bubule.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  final String email;
  ChatPage({super.key, required this.email});

  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollection,
  );

  final controller = TextEditingController();
  final _controllerScroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messageList = snapshot.data!.docs
              .map(
                (document) =>
                    Message.fromJson(document.data() as Map<String, dynamic>),
              )
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
                    reverse: true,
                    controller: _controllerScroll,
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
                      messages.add({
                        kMessage: data,
                        kCreatedAt: DateTime.now(),
                        'id': email,
                      });
                      controller.clear();
                      _controllerScroll.animateTo(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
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
