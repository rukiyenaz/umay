import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gebelik_aapp/features/home/domain/entities/chat_session.dart';
import 'package:gebelik_aapp/features/home/domain/entities/message_model.dart';
import 'package:gebelik_aapp/features/home/presentation/cubits/message_ai_cubit.dart';
import 'package:gebelik_aapp/features/home/presentation/cubits/message_ai_state.dart';
import 'package:hive/hive.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _messageController = TextEditingController();
  final _scrollController = ScrollController();

  Box<ChatSession>? chatBox;
  ChatSession? currentSession;

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }
  
  bool isLoading = false;

  Future<void> _initHive() async {
    chatBox = await Hive.openBox<ChatSession>('chat_sessions');

    // Varsayılan olarak en son sohbeti yükle
    if (chatBox!.isNotEmpty) {
      currentSession = chatBox!.values.last;
    } else {
      currentSession = ChatSession(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: "Yeni Sohbet",
        messages: [],
      );
      await chatBox!.put(currentSession!.id, currentSession!);
    }
  }

  @override
  void initState() {
    super.initState();
    _initHive().then((_) {
      setState(() {}); // Rebuild after initialization
    });
  }
  
  Future<void> _addMessage(MessageModel msg) async {
    if (currentSession == null) return;
    
    currentSession!.messages.add(msg);
    await chatBox!.put(currentSession!.id, currentSession!);
    context.read<MessageAICubit>().getChatsByTitle(currentSession!.title);
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageAICubit, MessageAIState>(
      listener: (context, state) {
        _scrollToBottom();
        if (state is MessageAIError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        // Return loading indicator if currentSession is not initialized yet
        if (currentSession == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        List<MessageModel> messages = currentSession!.messages;

        if (state is MessageAILoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MessageAILoaded) {
          messages = state.messages;
          for (var msg in state.messages) {
            _addMessage(msg);
          }
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 163, 196, 249),
            title: const Text('Home Page'),
          ),
          body: Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (_, index) {
                    final msg = messages[index];
                    final isUser = msg.role == "user";

                    return Align(
                      alignment: isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        padding: const EdgeInsets.all(12),
                        constraints: BoxConstraints(
                          maxWidth:
                              MediaQuery.of(context).size.width * 0.7, // max 70%
                        ),
                        decoration: BoxDecoration(
                          color: isUser
                              ? Colors.blue[100]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              msg.content,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isUser ? "User" : "AI",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Type a message',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        String message = _messageController.text.trim();
                        if (message.isNotEmpty) {
                          context.read<MessageAICubit>().sendAiMessage(message);
                          _messageController.clear();

                         // Hemen Hive’a kaydet
                          _addMessage(MessageModel(
                            role: "user",
                            content: message,
                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                          )); 
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
