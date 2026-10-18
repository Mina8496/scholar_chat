import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/core/constants.dart';
import 'package:scholar_chat/feature/chat_page/manger/chat_state.dart';
import 'package:scholar_chat/feature/chat_page/model/message.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());

  final CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollection,
  );
  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        kMessage: message,
        kCreatedAt: FieldValue.serverTimestamp(), // وقت السيرفر
        'id': email,
      });
    } on Exception catch (e) {
      //
    }
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      List<Message> messageList = [];
      for (var doc in event.docs) {
        messageList.add(Message.fromJson(doc));
      }
      emit(ChatSuccessState(messageList: messageList));
    });
  }
}
