import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'features/chat/chat_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KaiApp());
}

class KaiApp extends StatelessWidget {
  const KaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KAI Companion',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const ChatScreen(),
    );
  }
}