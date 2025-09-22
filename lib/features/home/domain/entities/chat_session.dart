import 'package:gebelik_aapp/features/home/domain/entities/message_model.dart';
import 'package:hive/hive.dart';

part 'chat_session.g.dart'; // Bu dosya build_runner ile üretilecek

@HiveType(typeId: 1)
class ChatSession extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  List<MessageModel> messages;

  ChatSession({
    required this.id, 
    required this.title, 
    List<MessageModel>? messages
  }) : messages = messages ?? [];
}