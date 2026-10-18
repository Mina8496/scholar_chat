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
      print(messageList);
      for (var doc in event.docs) {
        print('doc ${doc}');
        final data = doc.data();
        if (data is Map<String, dynamic>) {
          messageList.add(Message.fromJson(data));
        }
      }
      print('success');
      emit(ChatSuccessState(messageList: messageList));
    });
  }
}
