import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gebelik_aapp/features/home/data/gemini_service.dart';
import 'package:gebelik_aapp/features/home/domain/repositories/message_ai_repo.dart';
import 'package:gebelik_aapp/features/home/presentation/cubits/message_ai_cubit.dart';
import 'package:gebelik_aapp/features/home/presentation/pages/chatbot_page.dart';

void main() async{
  await dotenv.load(fileName: ".env");
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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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
    ], child: const HomePage());
  }
}

