import 'package:scholar_chat/core/constants.dart';

class Message {
  final String message;
  final String id;

  Message(this.message, this.id);

  factory Message.fromJson(Map<String, dynamic> jsonData) {
    return Message(jsonData[kMessage], jsonData['id']);
  }
}
