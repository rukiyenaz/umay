import 'package:gebelik_aapp/features/home/domain/entities/message_model.dart';

abstract class MessageAIState {
  final List<MessageModel> messages;
  const MessageAIState({this.messages = const []});
}

class MessageAIInitial extends MessageAIState {}

class MessageAILoading extends MessageAIState {
  const MessageAILoading({required List<MessageModel> messages})
      : super(messages: messages);
}

class MessageAILoaded extends MessageAIState {
  const MessageAILoaded({required List<MessageModel> messages})
      : super(messages: messages);
}

class MessageAIError extends MessageAIState {
  final String message;
  const MessageAIError({required List<MessageModel> messages, required this.message})
      : super(messages: messages);
}
