import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gebelik_aapp/features/home/data/gemini_service.dart';
import 'package:gebelik_aapp/features/home/domain/repositories/message_ai_repo.dart';
import 'package:gebelik_aapp/features/home/presentation/cubits/calendar_cubit.dart';
import 'package:gebelik_aapp/features/home/presentation/cubits/message_ai_cubit.dart';
import 'package:gebelik_aapp/features/home/presentation/pages/calendar_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ← Bu satır eklendi!
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const App(),
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
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<CalendarCubit>(
          create: (context) => CalendarCubit()..loadCalendar(),
        ),
        BlocProvider<MessageAICubit>(
          create: (context) => MessageAICubit(repository: messageaiRepo),
        ),
      ],
      child: const CalendarScreen(),
    );
  }
}
