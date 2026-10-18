import 'package:scholar_chat/feature/chat_page/model/message.dart';

abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatSuccessState extends ChatState {
  List<Message> messageList = [];
  ChatSuccessState({required this.messageList});
}
