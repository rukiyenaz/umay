import 'package:gebelik_aapp/features/home/domain/entities/message_model.dart';

abstract class MessageAIState {
  final List<MessageModel> messages;
  MessageAIState({this.messages = const []});
}

class MessageAIInitial extends MessageAIState {}
class MessageAILoading extends MessageAIState {}
class MessageAILoaded extends MessageAIState {

  MessageAILoaded({required MessageModel response}) : super(messages: [response]);
}

class MessageAIError extends MessageAIState {
  final String message;

  MessageAIError({required List<MessageModel> messages, required this.message}) : super(messages: messages);
}