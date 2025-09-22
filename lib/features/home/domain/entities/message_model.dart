import 'package:hive/hive.dart';

part 'message_model.g.dart'; // Bu dosya build_runner ile üretilecek


@HiveType(typeId: 0)
class MessageModel extends HiveObject {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String role;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final DateTime timestamp;

  MessageModel({required this.id, required this.role, required this.content, DateTime? timestamp})
      : timestamp = DateTime.now();

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      role: json['role'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}