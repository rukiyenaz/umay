import 'package:gebelik_aapp/features/home/domain/entities/message_model.dart';

abstract class MessageAIRepository {
  Future<String> getGeminiResponse(String prompt);
}