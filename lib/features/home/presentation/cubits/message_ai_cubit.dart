import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gebelik_aapp/features/home/domain/entities/chat_session.dart';
import 'package:gebelik_aapp/features/home/domain/entities/message_model.dart';
import 'package:gebelik_aapp/features/home/domain/repositories/message_ai_repo.dart';
import 'package:gebelik_aapp/features/home/presentation/cubits/message_ai_state.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';


class MessageAICubit extends Cubit<MessageAIState> {
  final MessageAIRepository repository;
  final _uuid = Uuid();

  MessageAICubit({required this.repository}) : super(MessageAIInitial());



  Future<void> fetchGeminiResponse(String prompt) async {
    final currentMessages = List<MessageModel>.from(state.messages);
    try {
      emit(MessageAILoading(messages: currentMessages));
      final response = await repository.getGeminiResponse(prompt);
      MessageModel aiMessage = MessageModel(
        id: _uuid.v4(),
        role: "ai",
        content: response,
      );
      if (response != null) {
        emit(MessageAILoaded(messages: [...currentMessages, aiMessage]));
      } else {
        emit(MessageAIError(messages: [...currentMessages, aiMessage], message: 'Yanıt alınamadı'));
      }
    } catch (e) {
      emit(MessageAIError(messages: currentMessages, message: e.toString()));
    }
  }

  void sendAiMessage(String message) {
    emit(MessageAILoading(messages: state.messages));
    try {
      final userMessage = MessageModel(
        id: _uuid.v4(),
        role: "user",
        content: message,
      );
      final currentMessages = List<MessageModel>.from(state.messages)..add(userMessage);  
    repository.getGeminiResponse(message).then((response) {
      MessageModel aiMessage = MessageModel(
        id: _uuid.v4(),
        role: "ai",
        content: response,
      );
      emit(MessageAILoaded(messages: [...currentMessages, aiMessage]));
    }).catchError((error) {
      emit(MessageAIError(messages: [...currentMessages, userMessage], message: error.toString()));
    });

    emit(MessageAILoaded(messages: [userMessage]));
    } catch (e) {
      emit( MessageAIError(messages: [], message: e.toString())); 
    }
  }

  Future<void> addNewChat(List<MessageModel> messages) async {
    final box = await Hive.openBox<ChatSession>('chat_sessions');
    final words = messages.first.content.split(' ');
    final title = words.take(2).join(' '); // İlk iki kelimeyi title olarak al

    final chat = ChatSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // benzersiz id
      title: title,
      messages: messages,
    );

    await box.put(chat.id, chat);
  }

  Future<List<ChatSession>> getChatsByTitle(String searchTitle) async {
    final box = await Hive.openBox<ChatSession>('chat_sessions');
    final allChats = box.values.toList();
    
    return allChats.where((chat) => chat.title == searchTitle).toList();
  }


}