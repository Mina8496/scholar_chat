import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/core/constants.dart';
import 'package:scholar_chat/core/widgets/custom_text_field.dart';
import 'package:scholar_chat/feature/chat_page/manger/chat_cubit.dart';
import 'package:scholar_chat/feature/chat_page/manger/chat_state.dart';
import 'package:scholar_chat/feature/chat_page/model/message.dart';
import 'package:scholar_chat/feature/chat_page/widget/chat_bubule.dart';

class ChatPage extends StatelessWidget {
  final String email;
  final controller = TextEditingController();
  final _controllerScroll = ScrollController();

  ChatPage({super.key, required this.email});
  List<Message> messageList = [];
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
            const Text('Scholar Chat', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer(
              listener: (context, state) {
                if (state is ChatSuccessState) {
                  messageList = state.messageList;
                }
              },
              builder: (context, state) => ListView.builder(
                reverse: true,
                controller: _controllerScroll,
                itemCount: messageList.length,
                itemBuilder: (context, index) {
                  return messageList[index].id == email
                      ? ChatBubule(message: messageList[index])
                      : ChatBubuleForAfrind(message: messageList[index]);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(
                  context,
                ).sendMessage(message: data, email: email);
              },
              hintStyle: const TextStyle(color: kPrimaryColor),
              hintText: 'Send Message',
              borderSide: const BorderSide(color: kPrimaryColor),
              suffixIcon: const Icon(Icons.send, color: kPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
