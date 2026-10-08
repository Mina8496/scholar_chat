import 'package:scholar_chat/core/constants.dart';

class Message {
  final String message;

  Message(this.message);

  factory Message.fromJson(Map<String, dynamic> jsonData) {
    return Message(jsonData[kMessage]);
  }
}
