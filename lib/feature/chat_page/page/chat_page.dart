import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constants.dart';
import 'package:scholar_chat/core/widgets/custom_text_field.dart';
import 'package:scholar_chat/feature/chat_page/model/message.dart';
import 'package:scholar_chat/feature/chat_page/widget/chat_bubule.dart';

class ChatPage extends StatefulWidget {
  final String email;
  const ChatPage({super.key, required this.email});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  final controller = TextEditingController();
  final _controllerScroll = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    _controllerScroll.dispose();
    super.dispose();
  }

  void _sendMessage(String data) {
    if (data.trim().isEmpty) return;

    messages.add({
      kMessage: data,
      kCreatedAt: FieldValue.serverTimestamp(), // وقت السيرفر
      'id': widget.email,
    });
    controller.clear();

    if (_controllerScroll.hasClients) {
      _controllerScroll.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messageList = snapshot.data!.docs
              .map((doc) =>
                  Message.fromJson(doc.data() as Map<String, dynamic>))
              .toList();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(kLogo, height: 50),
                  const Text('Scholar Chat',
                      style: TextStyle(color: Colors.white)),
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
                    itemBuilder: (context, index) {
                      return messageList[index].id == widget.email
                          ? ChatBubule(message: messageList[index])
                          : ChatBubuleForAfrind(message: messageList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomTextField(
                    controller: controller,
                    onSubmitted: _sendMessage,
                    hintStyle: const TextStyle(color: kPrimaryColor),
                    hintText: 'Send Message',
                    borderSide: const BorderSide(color: kPrimaryColor),
                    suffixIcon: const Icon(Icons.send, color: kPrimaryColor),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}