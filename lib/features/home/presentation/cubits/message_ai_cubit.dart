import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gebelik_aapp/features/home/domain/entities/message_model.dart';
import 'package:gebelik_aapp/features/home/domain/repositories/message_ai_repo.dart';
import 'package:gebelik_aapp/features/home/presentation/cubits/message_ai_state.dart';
import 'package:uuid/uuid.dart';


class MessageAICubit extends Cubit<MessageAIState> {
  final MessageAIRepository repository;
  final _uuid = Uuid();

  MessageAICubit({required this.repository}) : super(MessageAIInitial());



  Future<void> fetchGeminiResponse(String prompt) async {
    try {
      emit(MessageAILoading());
      final response = await repository.getGeminiResponse(prompt);
      MessageModel aiMessage = MessageModel(
        id: _uuid.v4(),
        role: MessageType.ai,
        content: response,
      );
      if (response != null) {
        emit(MessageAILoaded(response: aiMessage));
      } else {
        emit(MessageAIError(messages: [aiMessage], message: 'Yanıt alınamadı'));
      }
    } catch (e) {
      emit(MessageAIError(messages: [], message: e.toString()));
    }
  }

  void sendAiMessage(String message) {
    emit(MessageAILoading());
    try {
          final userMessage = MessageModel(
      id: _uuid.v4(),
      role: MessageType.user,
      content: message,
    );

    repository.getGeminiResponse(message).then((response) {
      MessageModel aiMessage = MessageModel(
        id: _uuid.v4(),
        role: MessageType.ai,
        content: response,
      );
      emit(MessageAILoaded(response: aiMessage));
    }).catchError((error) {
      emit(MessageAIError(messages: [userMessage], message: error.toString()));
    });

    emit(MessageAILoaded(response: userMessage));
    } catch (e) {
      emit( MessageAIError(messages: [], message: e.toString())); 
    }
  }
}