import 'package:scholar_chat/core/constants.dart';

class Message {
  final String message;

  Message(this.message);

  factory Message.fromJson(Map<String, dynamic> jsonData) {
    // Older chat entries were saved under `messages` (plural).
    final value = jsonData[kMessage] ?? jsonData['messages'];
    return Message(value is String ? value : '');
  }
}
