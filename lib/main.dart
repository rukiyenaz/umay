import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gebelik_aapp/features/egzersiz-beslenme/presentation/page/beslenme_page.dart';
import 'package:gebelik_aapp/features/egzersiz-beslenme/presentation/page/egzersiz_page.dart';
import 'package:gebelik_aapp/features/home/data/gemini_service.dart';
import 'package:gebelik_aapp/features/home/domain/entities/chat_session.dart';
import 'package:gebelik_aapp/features/home/domain/entities/message_model.dart';
import 'package:gebelik_aapp/features/home/domain/repositories/message_ai_repo.dart';
import 'package:gebelik_aapp/features/home/presentation/cubits/message_ai_cubit.dart';
import 'package:gebelik_aapp/features/home/presentation/pages/chatbot_page.dart';
import 'package:hive_flutter/adapters.dart';

void main() async{
  await dotenv.load(fileName: "assets/.env");
  await Hive.initFlutter();

  Hive.registerAdapter(MessageModelAdapter());
  Hive.registerAdapter(ChatSessionAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  MessageAIRepository messageaiRepo = GeminiAIService();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: <BlocProvider>[
      BlocProvider<MessageAICubit>(
        create: (context) => MessageAICubit(repository: messageaiRepo),
      ),
    ], child:  ChatbotPage()
    );
  }
}

