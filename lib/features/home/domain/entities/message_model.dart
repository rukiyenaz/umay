enum MessageType { user, ai }

class MessageModel {
  final String id;
  final MessageType role;
  final String content;
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
      'id': id,
      'role': role,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}